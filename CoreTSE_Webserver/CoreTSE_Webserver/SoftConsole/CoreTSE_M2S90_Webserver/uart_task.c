/*******************************************************************************
 * (c) Copyright 2014 Microsemi SoC Products Group.  All rights reserved.
 *
 *
 *
 * SVN $Revision:  $
 * SVN $Date:  $
 */

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "lwip/sys.h"

#include <stdio.h>

/* Driver includes */
#include "drivers/mss_uart/mss_uart.h"
#include "drivers/CoreTSE/core_tse.h"

extern tse_instance_t g_tse;

uint32_t get_ip_address(void);
void set_user_eth_filter_choice(uint32_t filter_choice);
void set_user_eth_speed_choice(uint32_t speed_choice);
void get_mac_address(uint8_t * mac_addr);

void read_mac_address(uint8_t * mac_addr, uint8_t *length);
void clear_mac_buf(void);
/*==============================================================================
 * Local functions.
 */
static void display_received_mac_addresses(void);
void send_msg(const uint8_t * p_msg);
void uart_tx_handler(mss_uart_instance_t * this_uart);
static void display_link_status(void);
static void display_instructions(void);
static void display_reset_msg(void);

/*==============================================================================
 * Global variables.
 */
static volatile const uint8_t * g_tx_buffer;
static volatile size_t g_tx_size = 0;
static char ip_addr_msg[128];

/*Broadcast address*/
uint8_t address_filter_broad[6] = {0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};

/*Unicast, multicast and broadcast address*/
uint8_t address_filter_hash [4][6] = {{0x10, 0x10, 0x10, 0x10, 0x10, 0x10},
                  {0x43, 0x40, 0x40, 0x40, 0x40, 0x43},
                  {0xC0, 0xB1, 0x3C, 0x60, 0x60, 0x60},
                  {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}};

static const uint8_t g_instructions_msg[] =
"----------------------------------------------------------------------\r\n\
Press a key to select:\r\n\n\
 Options to choose PHY interface parameters:\r\n\n\
  [1]: Enable auto-negotiation to all speeds\r\n\
  [2]: Select 1000Mpbs, Full-duplex \r\n\
  [3]: Select 1000Mpbs Half-duplex \r\n\
  [4]: Select 100Mpbs Full-duplex \r\n\
  [5]: Select 100Mpbs Half-duplex \r\n\
  [6]: Select 10Mpbs Full-duplex \r\n\
  [7]: Select 10Mpbs Half-duplex \r\n\
  [s]: Display link status (MAC address and IP)\r\n\n\
 Options to choose Frame Filtering Combination:\r\n\n\
  [a]: Receive all Multicast, Broadcast and Perfect-Unicast Match frames\r\n\
  [b]: Enable Promiscuous mode\r\n\
  [c]: Enable Broadcast Frames only, reject all other frames\r\n\
  [d]: Receive Broadcast,Unicast, Hash-Unicast and Hash-Multicast match frames\r\n\
  [m]: Display Received MAC addresses \r\n\
";

static const uint8_t g_reset_msg[] =
"\r\nApplying changes and resetting system.\r\n";

/*------------------------------------------------------------------------------
  UART selection.
  Replace the line below with this one if you want to use UART1 instead of
  UART0:
  mss_uart_instance_t * const gp_my_uart = &g_mss_uart1;
 */
static mss_uart_instance_t * const gp_my_uart = &g_mss_uart1;

/*==============================================================================
 * UART task.
 */
void prvUARTTask( void * pvParameters)
{

    /*--------------------------------------------------------------------------
     * Initialize and configure UART.
     */
#if 0
    MSS_UART_init(gp_my_uart,
                  MSS_UART_115200_BAUD,
                  MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

    MSS_UART_set_tx_handler(gp_my_uart, uart_tx_handler);

    send_msg((const uint8_t*)"\r\n\r\n**********************************************************************\r\n");
    send_msg((const uint8_t*)"********************* CoreTSE WebServer Example **********************\r\n");
    send_msg((const uint8_t*)"**********************************************************************\r\n\n");
    send_msg((const uint8_t*)"By default, only the Broadcast and Perfect-unicast-match frames are received\r\n");
#endif

    display_instructions();

    for( ;; )
    {
        size_t rx_size;
        uint8_t rx_buff[1];

        /* Run through loop every 500 milliseconds. */
        vTaskDelay(500 / portTICK_RATE_MS);

        /* Check for inpout from the user. */
        rx_size = MSS_UART_get_rx(gp_my_uart, rx_buff, sizeof(rx_buff));
        if(rx_size > 0)
        {
            switch(rx_buff[0])
            {
                case 'a':/*Receive Perfect Unicast, perfect Multicast and boardcast frames*/
                case 'A':
                    clear_mac_buf();
                    display_reset_msg();
                    set_user_eth_filter_choice(TSE_FC_PASS_BROADCAST_MASK |
                                               TSE_FC_PASS_MULTICAST_MASK |
                                               TSE_FC_PASS_UNICAST_MASK );
                break;

                case 'b':/*Enable Promiscuous mode*/
                case 'B':
                    clear_mac_buf();
                    display_reset_msg();
                    set_user_eth_filter_choice(TSE_FC_PROMISCOUS_MODE_MASK);
                break;

                case 'c':/*Enable Broadcast Frames only,reject all other frames*/
                case 'C':
                    clear_mac_buf();
                    display_reset_msg();
                    set_user_eth_filter_choice(TSE_FC_PASS_BROADCAST_MASK);
                break;

                case 'd':/*Receive Broadcast,unicast Hash-Unicast and Hash-Multicast match frames*/
                case 'D':
                    clear_mac_buf();
                    display_reset_msg();
                    TSE_set_address_filter(&g_tse, address_filter_hash[0], 4);
                break;

                case 'm':/*Display Received MAC addresses*/
                case 'M':
                    display_received_mac_addresses();
                break;

                case '1':
                    display_reset_msg();
                    set_user_eth_speed_choice(TSE_ANEG_ALL_SPEEDS);
                break;

                case '2':
                    display_reset_msg();
                    set_user_eth_speed_choice(TSE_ANEG_1000M_FD);
                break;

                case '3':
                    display_reset_msg();
                    set_user_eth_speed_choice(TSE_ANEG_1000M_HD);
                break;

                case '4':
                    display_reset_msg();
                    set_user_eth_speed_choice(TSE_ANEG_100M_FD);
                break;

                case '5':
                    display_reset_msg();
                    set_user_eth_speed_choice(TSE_ANEG_100M_HD);
                break;

                case '6':
                    display_reset_msg();
                    set_user_eth_speed_choice(TSE_ANEG_10M_FD);
                break;

                case '7':
                    display_reset_msg();
                    set_user_eth_speed_choice(TSE_ANEG_10M_HD);

                default:
                    display_link_status();
                break;
            }
            sys_msleep(5);
            display_instructions();
        }
    }
}
static void  display_received_mac_addresses(void)
{
    static uint8_t mac_addr[60];
    static uint8_t length;
    static uint8_t mac_addr_msg[128];
    uint8_t a;

    read_mac_address(mac_addr, &length);

    if(length)
    {
        for(a = 0; a < length; a += 6)
        {
            snprintf((char *)mac_addr_msg, sizeof(mac_addr_msg),"\r\n  MAC address: %02x:%02x:%02x:%02x:%02x:%02x \r\n",
                              mac_addr[0+a], mac_addr[1+a], mac_addr[2+a], mac_addr[3+a], mac_addr[4+a], mac_addr[5+a]);
             send_msg((const uint8_t*)mac_addr_msg);
        }
    }
}
/*==============================================================================
 *
 */
static void display_instructions(void)
{
    send_msg(g_instructions_msg);
}

/*==============================================================================
 *
 */
static void display_link_status(void)
{
    uint8_t link_up;
    uint8_t fullduplex;
    tse_speed_t speed;

    link_up = TSE_get_link_status(&g_tse,
                                  (tse_speed_t *)&speed,
                                  (uint8_t *)&fullduplex);
    if(1u == link_up)
    {
        uint32_t ip_addr;

        uint8_t mac_addr[6];

        send_msg((const uint8_t*)"----------------------------------------------------------------------\r\n");
        send_msg((const uint8_t*)" Ethernet link up:");

        ip_addr = get_ip_address();
        get_mac_address(mac_addr);
        snprintf(ip_addr_msg, sizeof(ip_addr_msg),
                 "\r\n  MAC address: %02x:%02x:%02x:%02x:%02x:%02x\r\n  TCP/IP address: %d.%d.%d.%d \r\n",
                  mac_addr[0], mac_addr[1], mac_addr[2], mac_addr[3], mac_addr[4], mac_addr[5],
                  (int)(ip_addr & 0x000000FFu),
                  (int)((ip_addr >> 8u) & 0x000000FFu),
                  (int)((ip_addr >> 16u) & 0x000000FFu),
                  (int)((ip_addr >> 24u) & 0x000000FFu));
        send_msg((const uint8_t*)ip_addr_msg);

        switch(speed)
        {
            case TSE_MAC10MBPS:
                send_msg((const uint8_t*)"  10Mbps ");
            break;

            case TSE_MAC100MBPS:
                send_msg((const uint8_t*)"  100Mbps ");
            break;

            case TSE_MAC1000MBPS:
                send_msg((const uint8_t*)"  1000Mbps ");
            break;

            default:
            break;
        }

        if(1u == fullduplex)
        {
            send_msg((const uint8_t*)"Full Duplex\r\n");
        }
        else
        {
            send_msg((const uint8_t*)"Half Duplex\r\n");
        }
        send_msg((const uint8_t*)"Use above IP address to access the WebServer using browser\r\n");
    }
    else
    {
        send_msg((const uint8_t*)"----------------------------------------------------------------------\r\n");
        send_msg((const uint8_t*)"\r\n Ethernet link down.\r\n");
    }
}

/*==============================================================================
 *
 */
void send_msg
(
    const uint8_t * p_msg
)
{
    size_t msg_size;
    size_t size_sent;

    while(g_tx_size > 0u)
    {
        /* Wait for previous message to complete tx. */
        ;
    }

    msg_size = 0u;
    while(p_msg[msg_size] != 0u)
    {
        ++msg_size;
    }

    g_tx_buffer = p_msg;
    g_tx_size = msg_size;

    size_sent = MSS_UART_fill_tx_fifo(gp_my_uart, p_msg, msg_size);
    g_tx_size = g_tx_size - size_sent;
    g_tx_buffer = &g_tx_buffer[size_sent];

    if(g_tx_size > 0u)
    {
        MSS_UART_enable_irq(gp_my_uart, MSS_UART_TBE_IRQ);
    }
}

/*==============================================================================
 *
 */
void uart_tx_handler(mss_uart_instance_t * this_uart)
{
    size_t size_in_fifo;

    if(g_tx_size > 0)
    {
        size_in_fifo = MSS_UART_fill_tx_fifo(this_uart,
                                             (const uint8_t *)g_tx_buffer,
                                             g_tx_size);

        if(size_in_fifo  ==  g_tx_size)
        {
            g_tx_size = 0;
            MSS_UART_disable_irq(this_uart, MSS_UART_TBE_IRQ);
        }
        else
        {
            g_tx_buffer = &g_tx_buffer[size_in_fifo];
            g_tx_size = g_tx_size - size_in_fifo;
        }
    }
    else
    {
        g_tx_size = 0;
        MSS_UART_disable_irq(this_uart, MSS_UART_TBE_IRQ);
    }
}

static void display_reset_msg(void)
{
    MSS_UART_polled_tx(gp_my_uart, g_reset_msg, sizeof(g_reset_msg));
    while(0 == MSS_UART_tx_complete(gp_my_uart))
    {
        ;
    }
}
