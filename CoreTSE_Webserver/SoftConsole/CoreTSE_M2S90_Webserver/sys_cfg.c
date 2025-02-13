/*******************************************************************************
 * (c) Copyright 2013 Microsemi SoC Products Group.  All rights reserved.
 *
 *
 *
 * SVN $Revision: $
 * SVN $Date: $
 */
#include "m2sxxx.h"
#include "drivers/CoreTSE/core_tse.h"
#include "core_cm3.h"

#define PO_RESET_DETECT_MASK    0x00000001u
#define VALID_SPEED_CHOICE_KEY  0xB16B00B5u

#if defined(__GNUC__)
__attribute__ ((section (".noinit")))  static uint32_t g_ethernet_speed_choice;
__attribute__ ((section (".noinit")))  static uint32_t g_ethernet_filter_choice;
__attribute__ ((section (".noinit")))  static uint32_t g_valid_choice_key;

#elif defined(__ICCARM__)
__no_init static uint32_t g_ethernet_speed_choice;
__no_init static uint32_t g_ethernet_filter_choice;
__no_init static uint32_t g_valid_choice_key;

#elif defined(__CC_ARM)
static uint32_t g_ethernet_speed_choice __attribute__((at(0x20000000)));  
static uint32_t g_ethernet_filter_choice   __attribute__((at(0x20000004)));
static uint32_t g_valid_choice_key __attribute__((at(0x20000008)));
#endif


/*==============================================================================
 *
 */
const uint8_t * sys_cfg_get_mac_address(void)
{
    static uint8_t mac_address[6];

    mac_address[0] = 0xC0u;
    mac_address[1] = 0xB1u;
    mac_address[2] = 0x3Cu;
    mac_address[3] = 0x60u;
    mac_address[4] = 0x60u;
    mac_address[5] = 0x50u;

    return (const uint8_t *)mac_address;
}


/*==============================================================================
 *
 */
void get_user_eth_config_choice(uint32_t* speed, uint32_t* filter)
{
    uint32_t power_on_reset;

    power_on_reset = SYSREG->RESET_SOURCE_CR & PO_RESET_DETECT_MASK;
    if(power_on_reset != 0u)
    {
        *speed = TSE_ANEG_ALL_SPEEDS;
        g_ethernet_speed_choice = TSE_ANEG_ALL_SPEEDS;

        *filter = TSE_FC_DEFAULT_MASK;
        g_ethernet_filter_choice = TSE_FC_DEFAULT_MASK;

        g_valid_choice_key = VALID_SPEED_CHOICE_KEY;
        SYSREG->RESET_SOURCE_CR &= ~PO_RESET_DETECT_MASK;
    }
    else
    {
        if(VALID_SPEED_CHOICE_KEY == g_valid_choice_key)
        {
            *speed = g_ethernet_speed_choice;
            *filter = g_ethernet_filter_choice;
        }
        else
        {
            *speed = TSE_ANEG_ALL_SPEEDS;
            g_ethernet_speed_choice = TSE_ANEG_ALL_SPEEDS;

            *filter = TSE_FC_DEFAULT_MASK;
            g_ethernet_filter_choice = TSE_FC_DEFAULT_MASK;

            g_valid_choice_key = VALID_SPEED_CHOICE_KEY;
        }
    }
}

/*==============================================================================
 *
 */
void set_user_eth_speed_choice(uint32_t speed_choice)
{
    g_ethernet_speed_choice = speed_choice;
    g_valid_choice_key = VALID_SPEED_CHOICE_KEY;
    NVIC_SystemReset();
}

/*==============================================================================
 *
 */
void set_user_eth_filter_choice(uint32_t filter_choice)
{
    g_ethernet_filter_choice = filter_choice;
    g_valid_choice_key = VALID_SPEED_CHOICE_KEY;
    NVIC_SystemReset();
}
