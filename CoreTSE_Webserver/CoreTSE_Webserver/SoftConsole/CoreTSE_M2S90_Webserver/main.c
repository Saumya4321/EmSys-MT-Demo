/*******************************************************************************
 * (c) Copyright 2014 Microsemi SoC Products Group.  All rights reserved.
 *
 * SmartFusion2 CoreTSE example web server using FreeRTOS and the lwIP TCP/IP stack.
 * Please refer to the README.TXT in this project's root folder to know more.
 *
 * SVN $Revision:  $
 * SVN $Date:  $
 */

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"

/* lwIP includes. */
#include "lwip/tcpip.h"
#include "lwip/dhcp.h"

#include "drivers/mss_gpio/mss_gpio.h"

/* CMSIS includes */
#include "CMSIS/system_m2sxxx.h"

/* Driver includes */
#include "drivers/mss_timer/mss_timer.h"
#include "drivers/mss_uart/mss_uart.h"
#include "drivers/CoreTSE/core_tse.h"
#include "ethernet_status.h"

/*==============================================================================
 *
 */
/* Priorities used by the various different tasks. */
#define mainuIP_TASK_PRIORITY                   (tskIDLE_PRIORITY + 2)
#define mainUART_TASK_PRIORITY                  (tskIDLE_PRIORITY + 1)
#define mainLinkStatus_TASK_PRIORITY            (tskIDLE_PRIORITY + 1)

/* Web server task stack size. */
#define HTTPD_STACK_SIZE                        400
#define UART_TASK_STACK_SIZE                    200
#define LINK_STATUS_TASK_STACK_SIZE             200

extern tse_instance_t g_tse;
#define ETHERNET_STATUS_QUEUE_LENGTH    1
#define DONT_BLOCK                      0

extern tse_instance_t g_tse;

uint32_t get_ip_address(void);

/*==============================================================================
 *
 */
 void ethernetif_tick(void);

/*
 * Setup the hardware platform.
 */
static void prvSetupHardware(void);

/*
 * Ethernet interface configuration function.
 */
static void prvEthernetConfigureInterface(void * param);

/*==============================================================================
 *
 */
/* The queue used by PTPd task to trnsmit status information to webserver task. */
xQueueHandle xPTPdOutQueue = NULL;

/*
 * The queue used by the EthLinkStatus task to communicate link speed/duplex
 * changes to the http_server task.
 */
xQueueHandle xEthStatusQueue = NULL;

/* lwIP MAC configuration. */
static struct netif s_EMAC_if;

/*==============================================================================
 *
 */
void prvUARTTask(void * pvParameters);
void prvLinkStatusTask(void * pvParameters);
void http_server_netconn_thread(void *arg);

static mss_uart_instance_t * const gp_my_uart = &g_mss_uart1;
extern void uart_tx_handler(mss_uart_instance_t * this_uart);
extern void send_msg(const uint8_t * p_msg);

/*==============================================================================
 *
 */
int main()
{

    /* Configure hardware platform. */
    prvSetupHardware();


    /*--------------------------------------------------------------------------
         * Initialize and configure UART.
         */
        MSS_UART_init(gp_my_uart,
                      MSS_UART_115200_BAUD,
                      MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

        MSS_UART_set_tx_handler(gp_my_uart, uart_tx_handler);

        send_msg((const uint8_t*)"\r\n\r\n**********************************************************************\r\n");
        send_msg((const uint8_t*)"********************* CoreTSE WebServer Example **********************\r\n");
        send_msg((const uint8_t*)"**********************************************************************\r\n\n");
        send_msg((const uint8_t*)"By default, only the Broadcast and Perfect-unicast-match frames are received\r\n");


    /*
     * Create the queue used by the EthLinkStatus task to communicate link
     * speed/duplex changes to the http_server task.
     */
    xEthStatusQueue = xQueueCreate(ETHERNET_STATUS_QUEUE_LENGTH, sizeof(ethernet_status_t));

    if(xEthStatusQueue != NULL)
    {
        /* Create the task handling user interractions through the UART. */
        xTaskCreate(prvUARTTask,
                    (signed char *) "UART",
                    UART_TASK_STACK_SIZE,
                    NULL,
                    mainUART_TASK_PRIORITY,
                    NULL);

        /* Create the web server task. */
        tcpip_init(prvEthernetConfigureInterface, NULL);
        xTaskCreate(http_server_netconn_thread,
                    (signed char *) "http_server",
                    HTTPD_STACK_SIZE,
                    NULL,
                    mainuIP_TASK_PRIORITY,
                    NULL );
        /* Create the task the Ethernet link status. */
        xTaskCreate(prvLinkStatusTask,
                    (signed char *) "EthLinkStatus",
                    LINK_STATUS_TASK_STACK_SIZE,
                    NULL,
                    mainLinkStatus_TASK_PRIORITY,
                    NULL);
        /* Start the tasks and timer running. */
        vTaskStartScheduler();
    }

    /*
     * If all is well, the scheduler will now be running, and the following line
     * will never be reached.  If the following line does execute, then there
     * was insufficient FreeRTOS heap memory available for the idle and/or timer
     * tasks to be created.  See the memory management section on the FreeRTOS
     * web site for more details.
     */
    for( ;; );
}

/*==============================================================================
 *
 */
static void prvSetupHardware( void )
{
    /*turn off the watchdog*/
    SYSREG->WDOG_CR = 0;

    /* Update global variables containing the system clock frequencies.*/
    SystemCoreClockUpdate();

	MSS_GPIO_init();
	MSS_GPIO_config( MSS_GPIO_0,  MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config( MSS_GPIO_1,  MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config( MSS_GPIO_2, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config( MSS_GPIO_3, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config( MSS_GPIO_4, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config( MSS_GPIO_5, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config( MSS_GPIO_6, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config( MSS_GPIO_7, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_set_outputs(0x0000);

    /* Enable cache. */
    SYSREG->CC_CR = 1u;
}

/*==============================================================================
 *
 */
void vApplicationMallocFailedHook( void )
{
    /*
     * Called if a call to pvPortMalloc() fails because there is insufficient
     * free memory available in the FreeRTOS heap.  pvPortMalloc() is called
     * internally by FreeRTOS API functions that create tasks, queues, software
     * timers, and semaphores.  The size of the FreeRTOS heap is set by the
     * configTOTAL_HEAP_SIZE configuration constant in FreeRTOSConfig.h.
     */
    for( ;; );
}

/*==============================================================================
 *
 */
void vApplicationStackOverflowHook( xTaskHandle *pxTask, signed char *pcTaskName )
{
    (void)pcTaskName;
    (void)pxTask;

    /*
     * Run time stack overflow checking is performed if
     * configconfigCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
     * function is called if a stack overflow is detected.
     */
    taskDISABLE_INTERRUPTS();
    for( ;; );
}

/*==============================================================================
 *
 */
void vApplicationIdleHook( void )
{
    volatile size_t xFreeStackSpace;

    /*
     * This function is called on each cycle of the idle task.  In this case it
     * does nothing useful, other than report the amount of FreeRTOS heap that
     * remains unallocated.
     */
    xFreeStackSpace = xPortGetFreeHeapSize();

    if( xFreeStackSpace > 100 )
    {
        /*
         * By now, the kernel has allocated everything it is going to, so if
         * there is a lot of heap remaining unallocated then the value of
         * configTOTAL_HEAP_SIZE in FreeRTOSConfig.h can be reduced accordingly.
         */
    }
}

/*==============================================================================
 *
 */
void vMainConfigureTimerForRunTimeStats( void )
{
const unsigned long ulMax32BitValue = 0xffffffffUL;

    MSS_TIM64_init( MSS_TIMER_PERIODIC_MODE );
    MSS_TIM64_load_immediate( ulMax32BitValue, ulMax32BitValue );
    MSS_TIM64_start();
}

/*==============================================================================
 *
 */
unsigned long ulGetRunTimeCounterValue( void )
{
    unsigned long long ullCurrentValue = 0u;
    const unsigned long long ulMax64BitValue = 0xffffffffffffffffULL;
    unsigned long *pulHighWord, *pulLowWord;

    pulHighWord = (unsigned long *)&ullCurrentValue;
    pulLowWord = pulHighWord++;

    MSS_TIM64_get_current_value((uint32_t *)pulHighWord, (uint32_t *)pulLowWord);

    /* Convert the down count into an upcount. */
    ullCurrentValue = ulMax64BitValue - ullCurrentValue;

    /* Scale to a 32bit number of suitable frequency. */
    ullCurrentValue >>= 13;

    /* Just return 32 bits. */
    return (unsigned long)ullCurrentValue;
}

/*==============================================================================
 *
 */
static void prvEthernetConfigureInterface(void * param)
{
    struct ip_addr xIpAddr, xNetMast, xGateway;
    extern err_t ethernetif_init( struct netif *netif );

    /* Parameters are not used - suppress compiler error. */
    ( void ) param;

    /* Create and configure the EMAC interface. */
#ifdef NET_USE_DHCP
    IP4_ADDR( &xIpAddr, 0, 0, 0, 0 );
    IP4_ADDR( &xGateway, 192, 168, 1, 254 );
#else
    IP4_ADDR( &xIpAddr, 169, 254, 1, 23 );
    IP4_ADDR( &xGateway, 169, 254, 1, 23 );
#endif

    IP4_ADDR( &xNetMast, 255, 255, 255, 0 );

    netif_add( &s_EMAC_if, &xIpAddr, &xNetMast, &xGateway, NULL, ethernetif_init, tcpip_input );

    /* bring it up */

#ifdef NET_USE_DHCP
    dhcp_start(&s_EMAC_if);
#else
    netif_set_up(&s_EMAC_if);
#endif

    /* make it the default interface */
    netif_set_default(&s_EMAC_if);
}

/*==============================================================================
 *
 */
uint32_t get_ip_address(void)
{
    return (uint32_t)(s_EMAC_if.ip_addr.addr);
}

/*==============================================================================
 *
 */
void get_mac_address(uint8_t * mac_addr)
{
    uint32_t inc;

    for(inc = 0; inc < 6; ++inc)
    {
        mac_addr[inc] = s_EMAC_if.hwaddr[inc];
    }
}

/*==============================================================================
 *
 */
void prvLinkStatusTask(void * pvParameters)
{
    ethernet_status_t status;

    status.speed = TSE_MAC10MBPS;
    status.duplex_mode = 0xFFU;

    for(;;)
    {
        volatile uint8_t linkup;
        uint8_t fullduplex;
        tse_speed_t speed;

        /* Run through loop every 500 milliseconds. */
        vTaskDelay(500 / portTICK_RATE_MS);

        linkup = TSE_get_link_status(&g_tse, &speed,  &fullduplex);
        if((speed != status.speed) || (fullduplex != status.duplex_mode))
        {
            status.speed = speed;
            status.duplex_mode = fullduplex;
            xQueueSend(xEthStatusQueue, &status, DONT_BLOCK );
        }

        ethernetif_tick();
    }
}

void led_test()
{
#if 0
    uint32_t gpio_pattern;
    int i=1;

    gpio_pattern = MSS_GPIO_get_outputs();
    for(i=1;i<256;i++)
    {
    MSS_GPIO_set_outputs( i);
    gpio_pattern = MSS_GPIO_get_outputs();
    delay(100000);
    }
    /*This delay is required to distinguish the ON and OFF of LEDs */
    return;
#endif
}
void delay ( volatile unsigned int n)
{
	while(n!=0)
	{
		n--;
	}
}

