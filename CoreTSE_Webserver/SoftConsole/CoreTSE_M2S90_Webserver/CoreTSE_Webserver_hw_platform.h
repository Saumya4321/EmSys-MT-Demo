#ifndef CoreTSE_Webserver_HW_PLATFORM_H_
#define CoreTSE_Webserver_HW_PLATFORM_H_
/*****************************************************************************
*
*Created by Microsemi SmartDesign  Thu Nov 17 16:02:36 2016
*
*Memory map specification for peripherals in CoreTSE_Webserver
*/

/*-----------------------------------------------------------------------------
* CM3 subsystem memory map
* Master(s) for this subsystem: CM3 FABRICTOMSSFIC0_AHB_BRIDGE 
*---------------------------------------------------------------------------*/
#define CORETSE_WEBSERVER_MSS_0         0x20000000U
#define CORETSE_AHB_0                   0x30000000U
#define SERDES_IF2_0                    0x40028000U


/*-----------------------------------------------------------------------------
* FIC32_0 subsystem memory map
* Master(s) for this subsystem: FIC32_0 CORETSE_AHB_0 CORETSE_AHB_0 
*---------------------------------------------------------------------------*/
#define CORETSE_WEBSERVER_MSS_0_FIC_0_AHB_SLAVE 0x20000000U
#define CORETSE_AHB_0_AHBS              0x30000000U


#endif /* CoreTSE_Webserver_HW_PLATFORM_H_*/
