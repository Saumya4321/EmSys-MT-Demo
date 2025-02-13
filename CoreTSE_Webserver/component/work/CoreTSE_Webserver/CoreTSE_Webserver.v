//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Nov 17 15:25:44 2016
// Version: v11.7 SP2 11.7.2.2
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// CoreTSE_Webserver
module CoreTSE_Webserver(
    // Inputs
    CLK1_PAD,
    DEVRST_N,
    MMUART_1_RXD,
    REFCLK1_N,
    REFCLK1_P,
    RXD0_N,
    RXD0_P,
    RXD1_N,
    RXD1_P,
    RXD2_N,
    RXD2_P,
    RXD3_N,
    RXD3_P,
    SPI_0_DI,
    SPI_1_DI,
    // Outputs
    GPIO_0_M2F,
    GPIO_1_M2F,
    GPIO_2_M2F,
    GPIO_3_M2F,
    GPIO_4_M2F,
    GPIO_5_M2F,
    GPIO_6_M2F,
    GPIO_7_M2F,
    MMUART_1_TXD,
    PHY_MDC,
    PHY_RST,
    SPI_0_DO,
    SPI_1_DO,
    TXD0_N,
    TXD0_P,
    TXD1_N,
    TXD1_P,
    TXD2_N,
    TXD2_P,
    TXD3_N,
    TXD3_P,
    // Inouts
    PHY_MDIO,
    SPI_0_CLK,
    SPI_0_SS0,
    SPI_1_CLK,
    SPI_1_SS0
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  CLK1_PAD;
input  DEVRST_N;
input  MMUART_1_RXD;
input  REFCLK1_N;
input  REFCLK1_P;
input  RXD0_N;
input  RXD0_P;
input  RXD1_N;
input  RXD1_P;
input  RXD2_N;
input  RXD2_P;
input  RXD3_N;
input  RXD3_P;
input  SPI_0_DI;
input  SPI_1_DI;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output GPIO_0_M2F;
output GPIO_1_M2F;
output GPIO_2_M2F;
output GPIO_3_M2F;
output GPIO_4_M2F;
output GPIO_5_M2F;
output GPIO_6_M2F;
output GPIO_7_M2F;
output MMUART_1_TXD;
output PHY_MDC;
output PHY_RST;
output SPI_0_DO;
output SPI_1_DO;
output TXD0_N;
output TXD0_P;
output TXD1_N;
output TXD1_P;
output TXD2_N;
output TXD2_P;
output TXD3_N;
output TXD3_P;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  PHY_MDIO;
inout  SPI_0_CLK;
inout  SPI_0_SS0;
inout  SPI_1_CLK;
inout  SPI_1_SS0;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          BIBUF_0_Y;
wire          CLK1_PAD;
wire   [31:0] CoreAHBLite_0_AHBmslave2_HADDR;
wire   [2:0]  CoreAHBLite_0_AHBmslave2_HBURST;
wire          CoreAHBLite_0_AHBmslave2_HMASTLOCK;
wire   [3:0]  CoreAHBLite_0_AHBmslave2_HPROT;
wire   [31:0] CoreAHBLite_0_AHBmslave2_HRDATA;
wire          CoreAHBLite_0_AHBmslave2_HREADY;
wire          CoreAHBLite_0_AHBmslave2_HREADYOUT;
wire          CoreAHBLite_0_AHBmslave2_HSELx;
wire   [1:0]  CoreAHBLite_0_AHBmslave2_HTRANS;
wire   [31:0] CoreAHBLite_0_AHBmslave2_HWDATA;
wire          CoreAHBLite_0_AHBmslave2_HWRITE;
wire   [31:0] CoreAHBLite_0_AHBmslave3_HADDR;
wire   [2:0]  CoreAHBLite_0_AHBmslave3_HBURST;
wire          CoreAHBLite_0_AHBmslave3_HMASTLOCK;
wire   [3:0]  CoreAHBLite_0_AHBmslave3_HPROT;
wire   [31:0] CoreAHBLite_0_AHBmslave3_HRDATA;
wire          CoreAHBLite_0_AHBmslave3_HREADY;
wire          CoreAHBLite_0_AHBmslave3_HREADYOUT;
wire   [1:0]  CoreAHBLite_0_AHBmslave3_HRESP;
wire          CoreAHBLite_0_AHBmslave3_HSELx;
wire   [2:0]  CoreAHBLite_0_AHBmslave3_HSIZE;
wire   [1:0]  CoreAHBLite_0_AHBmslave3_HTRANS;
wire   [31:0] CoreAHBLite_0_AHBmslave3_HWDATA;
wire          CoreAHBLite_0_AHBmslave3_HWRITE;
wire          CoreConfigP_0_APB_S_PCLK;
wire          CoreConfigP_0_APB_S_PRESET_N;
wire          CoreConfigP_0_CONFIG1_DONE;
wire          CoreConfigP_0_CONFIG2_DONE;
wire          CoreConfigP_0_SDIF0_APBmslave_PENABLE;
wire   [31:0] CoreConfigP_0_SDIF0_APBmslave_PRDATA;
wire          CoreConfigP_0_SDIF0_APBmslave_PREADY;
wire          CoreConfigP_0_SDIF0_APBmslave_PSELx;
wire          CoreConfigP_0_SDIF0_APBmslave_PSLVERR;
wire   [31:0] CoreConfigP_0_SDIF0_APBmslave_PWDATA;
wire          CoreConfigP_0_SDIF0_APBmslave_PWRITE;
wire          CoreResetP_0_INIT_DONE;
wire          CoreResetP_0_M3_RESET_N;
wire          CoreResetP_0_MSS_HPMS_READY;
wire          CoreResetP_0_RESET_N_F2M;
wire          CoreResetP_0_SDIF0_PHY_RESET_N;
wire          CoreResetP_0_SDIF_RELEASED;
wire   [31:0] CORETSE_AHB_0_AHBMRX_HADDR;
wire   [2:0]  CORETSE_AHB_0_AHBMRX_HBURST;
wire          CORETSE_AHB_0_AHBMRX_HBUSREQ;
wire          CORETSE_AHB_0_AHBMRX_HLOCK;
wire   [31:0] CORETSE_AHB_0_AHBMRX_HRDATA;
wire          CORETSE_AHB_0_AHBMRX_HREADY;
wire   [1:0]  CORETSE_AHB_0_AHBMRX_HRESP;
wire   [2:0]  CORETSE_AHB_0_AHBMRX_HSIZE;
wire   [1:0]  CORETSE_AHB_0_AHBMRX_HTRANS;
wire   [31:0] CORETSE_AHB_0_AHBMRX_HWDATA;
wire          CORETSE_AHB_0_AHBMRX_HWRITE;
wire   [31:0] CORETSE_AHB_0_AHBMTX_HADDR;
wire   [2:0]  CORETSE_AHB_0_AHBMTX_HBURST;
wire          CORETSE_AHB_0_AHBMTX_HBUSREQ;
wire          CORETSE_AHB_0_AHBMTX_HLOCK;
wire   [31:0] CORETSE_AHB_0_AHBMTX_HRDATA;
wire          CORETSE_AHB_0_AHBMTX_HREADY;
wire   [1:0]  CORETSE_AHB_0_AHBMTX_HRESP;
wire   [2:0]  CORETSE_AHB_0_AHBMTX_HSIZE;
wire   [1:0]  CORETSE_AHB_0_AHBMTX_HTRANS;
wire   [31:0] CORETSE_AHB_0_AHBMTX_HWDATA;
wire          CORETSE_AHB_0_AHBMTX_HWRITE;
wire          CORETSE_AHB_0_MDO;
wire          CORETSE_AHB_0_MDOEN;
wire          CORETSE_AHB_0_TBI_TXVAL;
wire   [9:0]  CORETSE_AHB_0_TCG;
wire   [0:0]  CORETSE_AHB_0_TSM_CONTROL0to0;
wire   [1:1]  CORETSE_AHB_0_TSM_CONTROL1to1;
wire   [0:0]  CORETSE_AHB_0_TSM_INTR0to0;
wire   [31:0] CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HADDR;
wire   [31:0] CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRDATA;
wire          CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HREADY;
wire   [1:0]  CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HTRANS;
wire   [31:0] CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HWDATA;
wire          CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HWRITE;
wire          CoreTSE_Webserver_MSS_0_FIC_2_APB_M_PCLK;
wire          CoreTSE_Webserver_MSS_0_FIC_2_APB_M_PRESET_N;
wire          CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PENABLE;
wire   [31:0] CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PRDATA;
wire          CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PREADY;
wire          CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PSELx;
wire          CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PSLVERR;
wire   [31:0] CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PWDATA;
wire          CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PWRITE;
wire          CoreTSE_Webserver_MSS_0_MSS_RESET_N_M2F;
wire          DEVRST_N;
wire          FCCC_0_GL0;
wire          FCCC_0_LOCK;
wire          FCCC_1_GL0;
wire          FCCC_1_GL1;
wire          FCCC_1_LOCK;
wire          FCCC_2_GL0;
wire          FCCC_2_LOCK;
wire          FCCC_3_GL0;
wire          FCCC_3_GL1;
wire          GPIO_0_M2F_net_0;
wire          GPIO_1_M2F_net_0;
wire          GPIO_2_M2F_net_0;
wire          GPIO_3_M2F_net_0;
wire          GPIO_4_M2F_net_0;
wire          GPIO_5_M2F_net_0;
wire          GPIO_6_M2F_net_0;
wire          GPIO_7_M2F_net_0;
wire          MMUART_1_RXD;
wire          MMUART_1_TXD_net_0;
wire          OSC_0_RCOSC_25_50MHZ_O2F;
wire          PHY_MDC_net_0;
wire          PHY_MDIO;
wire          PHY_RST_net_0;
wire          REFCLK1_N;
wire          REFCLK1_P;
wire          RXD0_N;
wire          RXD0_P;
wire          RXD1_N;
wire          RXD1_P;
wire          RXD2_N;
wire          RXD2_P;
wire          RXD3_N;
wire          RXD3_P;
wire          SERDES_IF2_0_EPCS_3_READY;
wire          SERDES_IF2_0_EPCS_3_RX_CLK;
wire   [9:0]  SERDES_IF2_0_EPCS_3_RX_DATA;
wire          SERDES_IF2_0_EPCS_3_TX_CLK;
wire          SPI_0_CLK;
wire          SPI_0_DI;
wire          SPI_0_DO_net_0;
wire          SPI_0_SS0;
wire          SPI_1_CLK;
wire          SPI_1_DI;
wire          SPI_1_DO_net_0;
wire          SPI_1_SS0;
wire          SYSRESET_0_POWER_ON_RESET_N;
wire          TXD0_N_net_0;
wire          TXD0_P_net_0;
wire          TXD1_N_net_0;
wire          TXD1_P_net_0;
wire          TXD2_N_net_0;
wire          TXD2_P_net_0;
wire          TXD3_N_net_0;
wire          TXD3_P_net_0;
wire          SPI_0_DO_net_1;
wire          SPI_1_DO_net_1;
wire          MMUART_1_TXD_net_1;
wire          TXD0_P_net_1;
wire          TXD0_N_net_1;
wire          TXD1_P_net_1;
wire          TXD1_N_net_1;
wire          TXD2_P_net_1;
wire          TXD2_N_net_1;
wire          TXD3_P_net_1;
wire          TXD3_N_net_1;
wire          GPIO_0_M2F_net_1;
wire          GPIO_1_M2F_net_1;
wire          GPIO_2_M2F_net_1;
wire          GPIO_3_M2F_net_1;
wire          GPIO_4_M2F_net_1;
wire          GPIO_5_M2F_net_1;
wire          GPIO_6_M2F_net_1;
wire          GPIO_7_M2F_net_1;
wire          PHY_MDC_net_1;
wire          PHY_RST_net_1;
wire   [31:2] TSM_CONTROL_slice_0;
wire   [2:1]  TSM_INTR_slice_0;
wire   [31:0] TSM_CONTROL_net_0;
wire   [2:0]  TSM_INTR_net_0;
wire   [15:0] MSS_INT_F2M_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
wire   [15:1] MSS_INT_F2M_const_net_0;
wire   [31:0] MDDR_PRDATA_const_net_0;
wire   [31:0] FDDR_PRDATA_const_net_0;
wire   [31:0] SDIF1_PRDATA_const_net_0;
wire   [31:0] SDIF2_PRDATA_const_net_0;
wire   [31:0] SDIF3_PRDATA_const_net_0;
wire   [31:0] SDIF0_PRDATA_const_net_0;
wire   [31:0] SDIF1_PRDATA_const_net_1;
wire   [31:0] SDIF2_PRDATA_const_net_1;
wire   [31:0] SDIF3_PRDATA_const_net_1;
wire   [7:0]  RXD_const_net_0;
wire   [7:2]  PADDR_const_net_0;
wire   [7:0]  PWDATA_const_net_0;
wire   [7:2]  PADDR_const_net_1;
wire   [7:0]  PWDATA_const_net_1;
wire   [7:2]  PADDR_const_net_2;
wire   [7:0]  PWDATA_const_net_2;
wire   [7:2]  PADDR_const_net_3;
wire   [7:0]  PWDATA_const_net_3;
wire   [19:0] EPCS_0_TX_DATA_const_net_0;
wire   [19:0] EPCS_1_TX_DATA_const_net_0;
wire   [19:0] EPCS_2_TX_DATA_const_net_0;
wire   [9:0]  SGMII_TX_DATA_const_net_0;
wire   [3:0]  AXI_0_M_BID_const_net_0;
wire   [1:0]  AXI_0_M_BRESP_const_net_0;
wire   [3:0]  AXI_0_M_RID_const_net_0;
wire   [63:0] AXI_0_M_RDATA_const_net_0;
wire   [1:0]  AXI_0_M_RRESP_const_net_0;
wire   [3:0]  AXI_0_S_AWID_const_net_0;
wire   [31:0] AXI_0_S_AWADDR_const_net_0;
wire   [3:0]  AXI_0_S_AWLEN_const_net_0;
wire   [1:0]  AXI_0_S_AWSIZE_const_net_0;
wire   [1:0]  AXI_0_S_AWBURST_const_net_0;
wire   [1:0]  AXI_0_S_AWLOCK_const_net_0;
wire   [3:0]  AXI_0_S_WID_const_net_0;
wire   [7:0]  AXI_0_S_WSTRB_const_net_0;
wire   [63:0] AXI_0_S_WDATA_const_net_0;
wire   [3:0]  AXI_0_S_ARID_const_net_0;
wire   [31:0] AXI_0_S_ARADDR_const_net_0;
wire   [3:0]  AXI_0_S_ARLEN_const_net_0;
wire   [1:0]  AXI_0_S_ARSIZE_const_net_0;
wire   [1:0]  AXI_0_S_ARBURST_const_net_0;
wire   [1:0]  AXI_0_S_ARLOCK_const_net_0;
wire   [3:0]  AXI_1_M_BID_const_net_0;
wire   [1:0]  AXI_1_M_BRESP_const_net_0;
wire   [3:0]  AXI_1_M_RID_const_net_0;
wire   [63:0] AXI_1_M_RDATA_const_net_0;
wire   [1:0]  AXI_1_M_RRESP_const_net_0;
wire   [3:0]  AXI_1_S_AWID_const_net_0;
wire   [31:0] AXI_1_S_AWADDR_const_net_0;
wire   [3:0]  AXI_1_S_AWLEN_const_net_0;
wire   [1:0]  AXI_1_S_AWSIZE_const_net_0;
wire   [1:0]  AXI_1_S_AWBURST_const_net_0;
wire   [1:0]  AXI_1_S_AWLOCK_const_net_0;
wire   [3:0]  AXI_1_S_WID_const_net_0;
wire   [7:0]  AXI_1_S_WSTRB_const_net_0;
wire   [63:0] AXI_1_S_WDATA_const_net_0;
wire   [3:0]  AXI_1_S_ARID_const_net_0;
wire   [31:0] AXI_1_S_ARADDR_const_net_0;
wire   [3:0]  AXI_1_S_ARLEN_const_net_0;
wire   [1:0]  AXI_1_S_ARSIZE_const_net_0;
wire   [1:0]  AXI_1_S_ARBURST_const_net_0;
wire   [1:0]  AXI_1_S_ARLOCK_const_net_0;
wire   [31:0] AHB_0_M_HRDATA_const_net_0;
wire   [31:0] AHB_0_S_HADDR_const_net_0;
wire   [2:0]  AHB_0_S_HBURST_const_net_0;
wire   [1:0]  AHB_0_S_HSIZE_const_net_0;
wire   [1:0]  AHB_0_S_HTRANS_const_net_0;
wire   [31:0] AHB_0_S_HWDATA_const_net_0;
wire   [31:0] AHB_1_M_HRDATA_const_net_0;
wire   [31:0] AHB_1_S_HADDR_const_net_0;
wire   [2:0]  AHB_1_S_HBURST_const_net_0;
wire   [1:0]  AHB_1_S_HSIZE_const_net_0;
wire   [1:0]  AHB_1_S_HTRANS_const_net_0;
wire   [31:0] AHB_1_S_HWDATA_const_net_0;
wire   [4:0]  XAUI_MMD_PRTAD_const_net_0;
wire   [4:0]  XAUI_MMD_DEVID_const_net_0;
wire   [63:0] XAUI_TXD_const_net_0;
wire   [7:0]  XAUI_TXC_const_net_0;
wire   [3:0]  PCIE_0_INTERRUPT_const_net_0;
wire   [3:0]  PCIE_1_INTERRUPT_const_net_0;
wire   [2:0]  HBURST_M0_const_net_0;
wire   [3:0]  HPROT_M0_const_net_0;
wire   [3:0]  HPROT_M1_const_net_0;
wire   [3:0]  HPROT_M2_const_net_0;
wire   [31:0] HADDR_M3_const_net_0;
wire   [1:0]  HTRANS_M3_const_net_0;
wire   [2:0]  HSIZE_M3_const_net_0;
wire   [2:0]  HBURST_M3_const_net_0;
wire   [3:0]  HPROT_M3_const_net_0;
wire   [31:0] HWDATA_M3_const_net_0;
wire   [31:0] HRDATA_S0_const_net_0;
wire   [1:0]  HRESP_S0_const_net_0;
wire   [31:0] HRDATA_S1_const_net_0;
wire   [1:0]  HRESP_S1_const_net_0;
wire   [31:0] HRDATA_S4_const_net_0;
wire   [1:0]  HRESP_S4_const_net_0;
wire   [31:0] HRDATA_S5_const_net_0;
wire   [1:0]  HRESP_S5_const_net_0;
wire   [31:0] HRDATA_S6_const_net_0;
wire   [1:0]  HRESP_S6_const_net_0;
wire   [31:0] HRDATA_S7_const_net_0;
wire   [1:0]  HRESP_S7_const_net_0;
wire   [31:0] HRDATA_S8_const_net_0;
wire   [1:0]  HRESP_S8_const_net_0;
wire   [31:0] HRDATA_S9_const_net_0;
wire   [1:0]  HRESP_S9_const_net_0;
wire   [31:0] HRDATA_S10_const_net_0;
wire   [1:0]  HRESP_S10_const_net_0;
wire   [31:0] HRDATA_S11_const_net_0;
wire   [1:0]  HRESP_S11_const_net_0;
wire   [31:0] HRDATA_S12_const_net_0;
wire   [1:0]  HRESP_S12_const_net_0;
wire   [31:0] HRDATA_S13_const_net_0;
wire   [1:0]  HRESP_S13_const_net_0;
wire   [31:0] HRDATA_S14_const_net_0;
wire   [1:0]  HRESP_S14_const_net_0;
wire   [31:0] HRDATA_S15_const_net_0;
wire   [1:0]  HRESP_S15_const_net_0;
wire   [31:0] HRDATA_S16_const_net_0;
wire   [1:0]  HRESP_S16_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [1:1]  CoreAHBLite_0_AHBmslave2_HRESP_0_1to1;
wire   [0:0]  CoreAHBLite_0_AHBmslave2_HRESP_0_0to0;
wire   [1:0]  CoreAHBLite_0_AHBmslave2_HRESP_0;
wire          CoreAHBLite_0_AHBmslave2_HRESP;
wire   [2:0]  CoreAHBLite_0_AHBmslave2_HSIZE;
wire   [1:0]  CoreAHBLite_0_AHBmslave2_HSIZE_0_1to0;
wire   [1:0]  CoreAHBLite_0_AHBmslave2_HSIZE_0;
wire   [15:2] CoreConfigP_0_SDIF0_APBmslave_PADDR;
wire   [14:2] CoreConfigP_0_SDIF0_APBmslave_PADDR_0_14to2;
wire   [14:2] CoreConfigP_0_SDIF0_APBmslave_PADDR_0;
wire   [1:0]  CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP;
wire   [0:0]  CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP_0_0to0;
wire          CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP_0;
wire   [2:2]  CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0_2to2;
wire   [1:0]  CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0_1to0;
wire   [2:0]  CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0;
wire   [1:0]  CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE;
wire   [16:16]CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0_16to16;
wire   [15:2] CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0_15to2;
wire   [16:2] CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0;
wire   [15:2] CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                      = 1'b1;
assign GND_net                      = 1'b0;
assign MSS_INT_F2M_const_net_0      = 15'h0000;
assign MDDR_PRDATA_const_net_0      = 32'h00000000;
assign FDDR_PRDATA_const_net_0      = 32'h00000000;
assign SDIF1_PRDATA_const_net_0     = 32'h00000000;
assign SDIF2_PRDATA_const_net_0     = 32'h00000000;
assign SDIF3_PRDATA_const_net_0     = 32'h00000000;
assign SDIF0_PRDATA_const_net_0     = 32'h00000000;
assign SDIF1_PRDATA_const_net_1     = 32'h00000000;
assign SDIF2_PRDATA_const_net_1     = 32'h00000000;
assign SDIF3_PRDATA_const_net_1     = 32'h00000000;
assign RXD_const_net_0              = 8'h00;
assign PADDR_const_net_0            = 6'h00;
assign PWDATA_const_net_0           = 8'h00;
assign PADDR_const_net_1            = 6'h00;
assign PWDATA_const_net_1           = 8'h00;
assign PADDR_const_net_2            = 6'h00;
assign PWDATA_const_net_2           = 8'h00;
assign PADDR_const_net_3            = 6'h00;
assign PWDATA_const_net_3           = 8'h00;
assign EPCS_0_TX_DATA_const_net_0   = 20'h00000;
assign EPCS_1_TX_DATA_const_net_0   = 20'h00000;
assign EPCS_2_TX_DATA_const_net_0   = 20'h00000;
assign SGMII_TX_DATA_const_net_0    = 10'h000;
assign AXI_0_M_BID_const_net_0      = 4'h0;
assign AXI_0_M_BRESP_const_net_0    = 2'h0;
assign AXI_0_M_RID_const_net_0      = 4'h0;
assign AXI_0_M_RDATA_const_net_0    = 64'h0000000000000000;
assign AXI_0_M_RRESP_const_net_0    = 2'h0;
assign AXI_0_S_AWID_const_net_0     = 4'h0;
assign AXI_0_S_AWADDR_const_net_0   = 32'h00000000;
assign AXI_0_S_AWLEN_const_net_0    = 4'h0;
assign AXI_0_S_AWSIZE_const_net_0   = 2'h0;
assign AXI_0_S_AWBURST_const_net_0  = 2'h0;
assign AXI_0_S_AWLOCK_const_net_0   = 2'h0;
assign AXI_0_S_WID_const_net_0      = 4'h0;
assign AXI_0_S_WSTRB_const_net_0    = 8'h00;
assign AXI_0_S_WDATA_const_net_0    = 64'h0000000000000000;
assign AXI_0_S_ARID_const_net_0     = 4'h0;
assign AXI_0_S_ARADDR_const_net_0   = 32'h00000000;
assign AXI_0_S_ARLEN_const_net_0    = 4'h0;
assign AXI_0_S_ARSIZE_const_net_0   = 2'h0;
assign AXI_0_S_ARBURST_const_net_0  = 2'h0;
assign AXI_0_S_ARLOCK_const_net_0   = 2'h0;
assign AXI_1_M_BID_const_net_0      = 4'h0;
assign AXI_1_M_BRESP_const_net_0    = 2'h0;
assign AXI_1_M_RID_const_net_0      = 4'h0;
assign AXI_1_M_RDATA_const_net_0    = 64'h0000000000000000;
assign AXI_1_M_RRESP_const_net_0    = 2'h0;
assign AXI_1_S_AWID_const_net_0     = 4'h0;
assign AXI_1_S_AWADDR_const_net_0   = 32'h00000000;
assign AXI_1_S_AWLEN_const_net_0    = 4'h0;
assign AXI_1_S_AWSIZE_const_net_0   = 2'h0;
assign AXI_1_S_AWBURST_const_net_0  = 2'h0;
assign AXI_1_S_AWLOCK_const_net_0   = 2'h0;
assign AXI_1_S_WID_const_net_0      = 4'h0;
assign AXI_1_S_WSTRB_const_net_0    = 8'h00;
assign AXI_1_S_WDATA_const_net_0    = 64'h0000000000000000;
assign AXI_1_S_ARID_const_net_0     = 4'h0;
assign AXI_1_S_ARADDR_const_net_0   = 32'h00000000;
assign AXI_1_S_ARLEN_const_net_0    = 4'h0;
assign AXI_1_S_ARSIZE_const_net_0   = 2'h0;
assign AXI_1_S_ARBURST_const_net_0  = 2'h0;
assign AXI_1_S_ARLOCK_const_net_0   = 2'h0;
assign AHB_0_M_HRDATA_const_net_0   = 32'h00000000;
assign AHB_0_S_HADDR_const_net_0    = 32'h00000000;
assign AHB_0_S_HBURST_const_net_0   = 3'h0;
assign AHB_0_S_HSIZE_const_net_0    = 2'h0;
assign AHB_0_S_HTRANS_const_net_0   = 2'h0;
assign AHB_0_S_HWDATA_const_net_0   = 32'h00000000;
assign AHB_1_M_HRDATA_const_net_0   = 32'h00000000;
assign AHB_1_S_HADDR_const_net_0    = 32'h00000000;
assign AHB_1_S_HBURST_const_net_0   = 3'h0;
assign AHB_1_S_HSIZE_const_net_0    = 2'h0;
assign AHB_1_S_HTRANS_const_net_0   = 2'h0;
assign AHB_1_S_HWDATA_const_net_0   = 32'h00000000;
assign XAUI_MMD_PRTAD_const_net_0   = 5'h00;
assign XAUI_MMD_DEVID_const_net_0   = 5'h00;
assign XAUI_TXD_const_net_0         = 64'h0000000000000000;
assign XAUI_TXC_const_net_0         = 8'h00;
assign PCIE_0_INTERRUPT_const_net_0 = 4'h0;
assign PCIE_1_INTERRUPT_const_net_0 = 4'h0;
assign HBURST_M0_const_net_0        = 3'h0;
assign HPROT_M0_const_net_0         = 4'h0;
assign HPROT_M1_const_net_0         = 4'h0;
assign HPROT_M2_const_net_0         = 4'h0;
assign HADDR_M3_const_net_0         = 32'h00000000;
assign HTRANS_M3_const_net_0        = 2'h0;
assign HSIZE_M3_const_net_0         = 3'h0;
assign HBURST_M3_const_net_0        = 3'h0;
assign HPROT_M3_const_net_0         = 4'h0;
assign HWDATA_M3_const_net_0        = 32'h00000000;
assign HRDATA_S0_const_net_0        = 32'h00000000;
assign HRESP_S0_const_net_0         = 2'h0;
assign HRDATA_S1_const_net_0        = 32'h00000000;
assign HRESP_S1_const_net_0         = 2'h0;
assign HRDATA_S4_const_net_0        = 32'h00000000;
assign HRESP_S4_const_net_0         = 2'h0;
assign HRDATA_S5_const_net_0        = 32'h00000000;
assign HRESP_S5_const_net_0         = 2'h0;
assign HRDATA_S6_const_net_0        = 32'h00000000;
assign HRESP_S6_const_net_0         = 2'h0;
assign HRDATA_S7_const_net_0        = 32'h00000000;
assign HRESP_S7_const_net_0         = 2'h0;
assign HRDATA_S8_const_net_0        = 32'h00000000;
assign HRESP_S8_const_net_0         = 2'h0;
assign HRDATA_S9_const_net_0        = 32'h00000000;
assign HRESP_S9_const_net_0         = 2'h0;
assign HRDATA_S10_const_net_0       = 32'h00000000;
assign HRESP_S10_const_net_0        = 2'h0;
assign HRDATA_S11_const_net_0       = 32'h00000000;
assign HRESP_S11_const_net_0        = 2'h0;
assign HRDATA_S12_const_net_0       = 32'h00000000;
assign HRESP_S12_const_net_0        = 2'h0;
assign HRDATA_S13_const_net_0       = 32'h00000000;
assign HRESP_S13_const_net_0        = 2'h0;
assign HRDATA_S14_const_net_0       = 32'h00000000;
assign HRESP_S14_const_net_0        = 2'h0;
assign HRDATA_S15_const_net_0       = 32'h00000000;
assign HRESP_S15_const_net_0        = 2'h0;
assign HRDATA_S16_const_net_0       = 32'h00000000;
assign HRESP_S16_const_net_0        = 2'h0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign SPI_0_DO_net_1     = SPI_0_DO_net_0;
assign SPI_0_DO           = SPI_0_DO_net_1;
assign SPI_1_DO_net_1     = SPI_1_DO_net_0;
assign SPI_1_DO           = SPI_1_DO_net_1;
assign MMUART_1_TXD_net_1 = MMUART_1_TXD_net_0;
assign MMUART_1_TXD       = MMUART_1_TXD_net_1;
assign TXD0_P_net_1       = TXD0_P_net_0;
assign TXD0_P             = TXD0_P_net_1;
assign TXD0_N_net_1       = TXD0_N_net_0;
assign TXD0_N             = TXD0_N_net_1;
assign TXD1_P_net_1       = TXD1_P_net_0;
assign TXD1_P             = TXD1_P_net_1;
assign TXD1_N_net_1       = TXD1_N_net_0;
assign TXD1_N             = TXD1_N_net_1;
assign TXD2_P_net_1       = TXD2_P_net_0;
assign TXD2_P             = TXD2_P_net_1;
assign TXD2_N_net_1       = TXD2_N_net_0;
assign TXD2_N             = TXD2_N_net_1;
assign TXD3_P_net_1       = TXD3_P_net_0;
assign TXD3_P             = TXD3_P_net_1;
assign TXD3_N_net_1       = TXD3_N_net_0;
assign TXD3_N             = TXD3_N_net_1;
assign GPIO_0_M2F_net_1   = GPIO_0_M2F_net_0;
assign GPIO_0_M2F         = GPIO_0_M2F_net_1;
assign GPIO_1_M2F_net_1   = GPIO_1_M2F_net_0;
assign GPIO_1_M2F         = GPIO_1_M2F_net_1;
assign GPIO_2_M2F_net_1   = GPIO_2_M2F_net_0;
assign GPIO_2_M2F         = GPIO_2_M2F_net_1;
assign GPIO_3_M2F_net_1   = GPIO_3_M2F_net_0;
assign GPIO_3_M2F         = GPIO_3_M2F_net_1;
assign GPIO_4_M2F_net_1   = GPIO_4_M2F_net_0;
assign GPIO_4_M2F         = GPIO_4_M2F_net_1;
assign GPIO_5_M2F_net_1   = GPIO_5_M2F_net_0;
assign GPIO_5_M2F         = GPIO_5_M2F_net_1;
assign GPIO_6_M2F_net_1   = GPIO_6_M2F_net_0;
assign GPIO_6_M2F         = GPIO_6_M2F_net_1;
assign GPIO_7_M2F_net_1   = GPIO_7_M2F_net_0;
assign GPIO_7_M2F         = GPIO_7_M2F_net_1;
assign PHY_MDC_net_1      = PHY_MDC_net_0;
assign PHY_MDC            = PHY_MDC_net_1;
assign PHY_RST_net_1      = PHY_RST_net_0;
assign PHY_RST            = PHY_RST_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign CORETSE_AHB_0_TSM_CONTROL0to0[0] = TSM_CONTROL_net_0[0:0];
assign CORETSE_AHB_0_TSM_CONTROL1to1[1] = TSM_CONTROL_net_0[1:1];
assign CORETSE_AHB_0_TSM_INTR0to0[0]    = TSM_INTR_net_0[0:0];
assign TSM_CONTROL_slice_0              = TSM_CONTROL_net_0[31:2];
assign TSM_INTR_slice_0                 = TSM_INTR_net_0[2:1];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign MSS_INT_F2M_net_0 = { 15'h0000 , CORETSE_AHB_0_TSM_INTR0to0[0] };
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign CoreAHBLite_0_AHBmslave2_HRESP_0_1to1 = 1'b0;
assign CoreAHBLite_0_AHBmslave2_HRESP_0_0to0 = CoreAHBLite_0_AHBmslave2_HRESP;
assign CoreAHBLite_0_AHBmslave2_HRESP_0 = { CoreAHBLite_0_AHBmslave2_HRESP_0_1to1, CoreAHBLite_0_AHBmslave2_HRESP_0_0to0 };

assign CoreAHBLite_0_AHBmslave2_HSIZE_0_1to0 = CoreAHBLite_0_AHBmslave2_HSIZE[1:0];
assign CoreAHBLite_0_AHBmslave2_HSIZE_0 = { CoreAHBLite_0_AHBmslave2_HSIZE_0_1to0 };

assign CoreConfigP_0_SDIF0_APBmslave_PADDR_0_14to2 = CoreConfigP_0_SDIF0_APBmslave_PADDR[14:2];
assign CoreConfigP_0_SDIF0_APBmslave_PADDR_0 = { CoreConfigP_0_SDIF0_APBmslave_PADDR_0_14to2 };

assign CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP_0_0to0 = CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP[0:0];
assign CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP_0 = { CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP_0_0to0 };

assign CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0_2to2 = 1'b0;
assign CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0_1to0 = CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE[1:0];
assign CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0 = { CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0_2to2, CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0_1to0 };

assign CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0_16to16 = 1'b0;
assign CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0_15to2 = CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR[15:2];
assign CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0 = { CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0_16to16, CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0_15to2 };

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( FCCC_2_LOCK ),
        .B ( FCCC_1_LOCK ),
        // Outputs
        .Y ( PHY_RST_net_0 ) 
        );

//--------BIBUF
BIBUF BIBUF_0(
        // Inputs
        .D   ( CORETSE_AHB_0_MDO ),
        .E   ( CORETSE_AHB_0_MDOEN ),
        // Outputs
        .Y   ( BIBUF_0_Y ),
        // Inouts
        .PAD ( PHY_MDIO ) 
        );

//--------CoreAHBLite   -   Actel:DirectCore:CoreAHBLite:5.2.100
CoreAHBLite #( 
        .FAMILY             ( 19 ),
        .HADDR_SHG_CFG      ( 1 ),
        .M0_AHBSLOT0ENABLE  ( 0 ),
        .M0_AHBSLOT1ENABLE  ( 0 ),
        .M0_AHBSLOT2ENABLE  ( 0 ),
        .M0_AHBSLOT3ENABLE  ( 1 ),
        .M0_AHBSLOT4ENABLE  ( 0 ),
        .M0_AHBSLOT5ENABLE  ( 0 ),
        .M0_AHBSLOT6ENABLE  ( 0 ),
        .M0_AHBSLOT7ENABLE  ( 0 ),
        .M0_AHBSLOT8ENABLE  ( 0 ),
        .M0_AHBSLOT9ENABLE  ( 0 ),
        .M0_AHBSLOT10ENABLE ( 0 ),
        .M0_AHBSLOT11ENABLE ( 0 ),
        .M0_AHBSLOT12ENABLE ( 0 ),
        .M0_AHBSLOT13ENABLE ( 0 ),
        .M0_AHBSLOT14ENABLE ( 0 ),
        .M0_AHBSLOT15ENABLE ( 0 ),
        .M0_AHBSLOT16ENABLE ( 0 ),
        .M1_AHBSLOT0ENABLE  ( 0 ),
        .M1_AHBSLOT1ENABLE  ( 0 ),
        .M1_AHBSLOT2ENABLE  ( 1 ),
        .M1_AHBSLOT3ENABLE  ( 0 ),
        .M1_AHBSLOT4ENABLE  ( 0 ),
        .M1_AHBSLOT5ENABLE  ( 0 ),
        .M1_AHBSLOT6ENABLE  ( 0 ),
        .M1_AHBSLOT7ENABLE  ( 0 ),
        .M1_AHBSLOT8ENABLE  ( 0 ),
        .M1_AHBSLOT9ENABLE  ( 0 ),
        .M1_AHBSLOT10ENABLE ( 0 ),
        .M1_AHBSLOT11ENABLE ( 0 ),
        .M1_AHBSLOT12ENABLE ( 0 ),
        .M1_AHBSLOT13ENABLE ( 0 ),
        .M1_AHBSLOT14ENABLE ( 0 ),
        .M1_AHBSLOT15ENABLE ( 0 ),
        .M1_AHBSLOT16ENABLE ( 0 ),
        .M2_AHBSLOT0ENABLE  ( 0 ),
        .M2_AHBSLOT1ENABLE  ( 0 ),
        .M2_AHBSLOT2ENABLE  ( 1 ),
        .M2_AHBSLOT3ENABLE  ( 0 ),
        .M2_AHBSLOT4ENABLE  ( 0 ),
        .M2_AHBSLOT5ENABLE  ( 0 ),
        .M2_AHBSLOT6ENABLE  ( 0 ),
        .M2_AHBSLOT7ENABLE  ( 0 ),
        .M2_AHBSLOT8ENABLE  ( 0 ),
        .M2_AHBSLOT9ENABLE  ( 0 ),
        .M2_AHBSLOT10ENABLE ( 0 ),
        .M2_AHBSLOT11ENABLE ( 0 ),
        .M2_AHBSLOT12ENABLE ( 0 ),
        .M2_AHBSLOT13ENABLE ( 0 ),
        .M2_AHBSLOT14ENABLE ( 0 ),
        .M2_AHBSLOT15ENABLE ( 0 ),
        .M2_AHBSLOT16ENABLE ( 0 ),
        .M3_AHBSLOT0ENABLE  ( 0 ),
        .M3_AHBSLOT1ENABLE  ( 0 ),
        .M3_AHBSLOT2ENABLE  ( 0 ),
        .M3_AHBSLOT3ENABLE  ( 0 ),
        .M3_AHBSLOT4ENABLE  ( 0 ),
        .M3_AHBSLOT5ENABLE  ( 0 ),
        .M3_AHBSLOT6ENABLE  ( 0 ),
        .M3_AHBSLOT7ENABLE  ( 0 ),
        .M3_AHBSLOT8ENABLE  ( 0 ),
        .M3_AHBSLOT9ENABLE  ( 0 ),
        .M3_AHBSLOT10ENABLE ( 0 ),
        .M3_AHBSLOT11ENABLE ( 0 ),
        .M3_AHBSLOT12ENABLE ( 0 ),
        .M3_AHBSLOT13ENABLE ( 0 ),
        .M3_AHBSLOT14ENABLE ( 0 ),
        .M3_AHBSLOT15ENABLE ( 0 ),
        .M3_AHBSLOT16ENABLE ( 0 ),
        .MEMSPACE           ( 1 ),
        .SC_0               ( 0 ),
        .SC_1               ( 0 ),
        .SC_2               ( 0 ),
        .SC_3               ( 0 ),
        .SC_4               ( 0 ),
        .SC_5               ( 0 ),
        .SC_6               ( 0 ),
        .SC_7               ( 0 ),
        .SC_8               ( 0 ),
        .SC_9               ( 0 ),
        .SC_10              ( 0 ),
        .SC_11              ( 0 ),
        .SC_12              ( 0 ),
        .SC_13              ( 0 ),
        .SC_14              ( 0 ),
        .SC_15              ( 0 ) )
CoreAHBLite_0(
        // Inputs
        .HCLK          ( FCCC_0_GL0 ),
        .HRESETN       ( CoreResetP_0_MSS_HPMS_READY ),
        .REMAP_M0      ( GND_net ), // tied to 1'b0 from definition
        .HMASTLOCK_M0  ( GND_net ), // tied to 1'b0 from definition
        .HWRITE_M0     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HWRITE ),
        .HMASTLOCK_M1  ( CORETSE_AHB_0_AHBMTX_HLOCK ),
        .HWRITE_M1     ( CORETSE_AHB_0_AHBMTX_HWRITE ),
        .HMASTLOCK_M2  ( CORETSE_AHB_0_AHBMRX_HLOCK ),
        .HWRITE_M2     ( CORETSE_AHB_0_AHBMRX_HWRITE ),
        .HMASTLOCK_M3  ( GND_net ), // tied to 1'b0 from definition
        .HWRITE_M3     ( GND_net ), // tied to 1'b0 from definition
        .HREADYOUT_S0  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S1  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S2  ( CoreAHBLite_0_AHBmslave2_HREADYOUT ),
        .HREADYOUT_S3  ( CoreAHBLite_0_AHBmslave3_HREADYOUT ),
        .HREADYOUT_S4  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S5  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S6  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S7  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S8  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S9  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S10 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S11 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S12 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S13 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S14 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S15 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S16 ( VCC_net ), // tied to 1'b1 from definition
        .HADDR_M0      ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HADDR ),
        .HSIZE_M0      ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE_0 ),
        .HTRANS_M0     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HTRANS ),
        .HWDATA_M0     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HWDATA ),
        .HBURST_M0     ( HBURST_M0_const_net_0 ), // tied to 3'h0 from definition
        .HPROT_M0      ( HPROT_M0_const_net_0 ), // tied to 4'h0 from definition
        .HADDR_M1      ( CORETSE_AHB_0_AHBMTX_HADDR ),
        .HSIZE_M1      ( CORETSE_AHB_0_AHBMTX_HSIZE ),
        .HTRANS_M1     ( CORETSE_AHB_0_AHBMTX_HTRANS ),
        .HWDATA_M1     ( CORETSE_AHB_0_AHBMTX_HWDATA ),
        .HBURST_M1     ( CORETSE_AHB_0_AHBMTX_HBURST ),
        .HPROT_M1      ( HPROT_M1_const_net_0 ), // tied to 4'h0 from definition
        .HADDR_M2      ( CORETSE_AHB_0_AHBMRX_HADDR ),
        .HSIZE_M2      ( CORETSE_AHB_0_AHBMRX_HSIZE ),
        .HTRANS_M2     ( CORETSE_AHB_0_AHBMRX_HTRANS ),
        .HWDATA_M2     ( CORETSE_AHB_0_AHBMRX_HWDATA ),
        .HBURST_M2     ( CORETSE_AHB_0_AHBMRX_HBURST ),
        .HPROT_M2      ( HPROT_M2_const_net_0 ), // tied to 4'h0 from definition
        .HADDR_M3      ( HADDR_M3_const_net_0 ), // tied to 32'h00000000 from definition
        .HSIZE_M3      ( HSIZE_M3_const_net_0 ), // tied to 3'h0 from definition
        .HTRANS_M3     ( HTRANS_M3_const_net_0 ), // tied to 2'h0 from definition
        .HWDATA_M3     ( HWDATA_M3_const_net_0 ), // tied to 32'h00000000 from definition
        .HBURST_M3     ( HBURST_M3_const_net_0 ), // tied to 3'h0 from definition
        .HPROT_M3      ( HPROT_M3_const_net_0 ), // tied to 4'h0 from definition
        .HRDATA_S0     ( HRDATA_S0_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S0      ( HRESP_S0_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S1     ( HRDATA_S1_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S1      ( HRESP_S1_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S2     ( CoreAHBLite_0_AHBmslave2_HRDATA ),
        .HRESP_S2      ( CoreAHBLite_0_AHBmslave2_HRESP_0 ),
        .HRDATA_S3     ( CoreAHBLite_0_AHBmslave3_HRDATA ),
        .HRESP_S3      ( CoreAHBLite_0_AHBmslave3_HRESP ),
        .HRDATA_S4     ( HRDATA_S4_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S4      ( HRESP_S4_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S5     ( HRDATA_S5_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S5      ( HRESP_S5_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S6     ( HRDATA_S6_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S6      ( HRESP_S6_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S7     ( HRDATA_S7_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S7      ( HRESP_S7_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S8     ( HRDATA_S8_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S8      ( HRESP_S8_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S9     ( HRDATA_S9_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S9      ( HRESP_S9_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S10    ( HRDATA_S10_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S10     ( HRESP_S10_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S11    ( HRDATA_S11_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S11     ( HRESP_S11_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S12    ( HRDATA_S12_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S12     ( HRESP_S12_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S13    ( HRDATA_S13_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S13     ( HRESP_S13_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S14    ( HRDATA_S14_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S14     ( HRESP_S14_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S15    ( HRDATA_S15_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S15     ( HRESP_S15_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S16    ( HRDATA_S16_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S16     ( HRESP_S16_const_net_0 ), // tied to 2'h0 from definition
        // Outputs
        .HREADY_M0     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HREADY ),
        .HREADY_M1     ( CORETSE_AHB_0_AHBMTX_HREADY ),
        .HREADY_M2     ( CORETSE_AHB_0_AHBMRX_HREADY ),
        .HREADY_M3     (  ),
        .HSEL_S0       (  ),
        .HWRITE_S0     (  ),
        .HREADY_S0     (  ),
        .HMASTLOCK_S0  (  ),
        .HSEL_S1       (  ),
        .HWRITE_S1     (  ),
        .HREADY_S1     (  ),
        .HMASTLOCK_S1  (  ),
        .HSEL_S2       ( CoreAHBLite_0_AHBmslave2_HSELx ),
        .HWRITE_S2     ( CoreAHBLite_0_AHBmslave2_HWRITE ),
        .HREADY_S2     ( CoreAHBLite_0_AHBmslave2_HREADY ),
        .HMASTLOCK_S2  ( CoreAHBLite_0_AHBmslave2_HMASTLOCK ),
        .HSEL_S3       ( CoreAHBLite_0_AHBmslave3_HSELx ),
        .HWRITE_S3     ( CoreAHBLite_0_AHBmslave3_HWRITE ),
        .HREADY_S3     ( CoreAHBLite_0_AHBmslave3_HREADY ),
        .HMASTLOCK_S3  ( CoreAHBLite_0_AHBmslave3_HMASTLOCK ),
        .HSEL_S4       (  ),
        .HWRITE_S4     (  ),
        .HREADY_S4     (  ),
        .HMASTLOCK_S4  (  ),
        .HSEL_S5       (  ),
        .HWRITE_S5     (  ),
        .HREADY_S5     (  ),
        .HMASTLOCK_S5  (  ),
        .HSEL_S6       (  ),
        .HWRITE_S6     (  ),
        .HREADY_S6     (  ),
        .HMASTLOCK_S6  (  ),
        .HSEL_S7       (  ),
        .HWRITE_S7     (  ),
        .HREADY_S7     (  ),
        .HMASTLOCK_S7  (  ),
        .HSEL_S8       (  ),
        .HWRITE_S8     (  ),
        .HREADY_S8     (  ),
        .HMASTLOCK_S8  (  ),
        .HSEL_S9       (  ),
        .HWRITE_S9     (  ),
        .HREADY_S9     (  ),
        .HMASTLOCK_S9  (  ),
        .HSEL_S10      (  ),
        .HWRITE_S10    (  ),
        .HREADY_S10    (  ),
        .HMASTLOCK_S10 (  ),
        .HSEL_S11      (  ),
        .HWRITE_S11    (  ),
        .HREADY_S11    (  ),
        .HMASTLOCK_S11 (  ),
        .HSEL_S12      (  ),
        .HWRITE_S12    (  ),
        .HREADY_S12    (  ),
        .HMASTLOCK_S12 (  ),
        .HSEL_S13      (  ),
        .HWRITE_S13    (  ),
        .HREADY_S13    (  ),
        .HMASTLOCK_S13 (  ),
        .HSEL_S14      (  ),
        .HWRITE_S14    (  ),
        .HREADY_S14    (  ),
        .HMASTLOCK_S14 (  ),
        .HSEL_S15      (  ),
        .HWRITE_S15    (  ),
        .HREADY_S15    (  ),
        .HMASTLOCK_S15 (  ),
        .HSEL_S16      (  ),
        .HWRITE_S16    (  ),
        .HREADY_S16    (  ),
        .HMASTLOCK_S16 (  ),
        .HRESP_M0      ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP ),
        .HRDATA_M0     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRDATA ),
        .HRESP_M1      ( CORETSE_AHB_0_AHBMTX_HRESP ),
        .HRDATA_M1     ( CORETSE_AHB_0_AHBMTX_HRDATA ),
        .HRESP_M2      ( CORETSE_AHB_0_AHBMRX_HRESP ),
        .HRDATA_M2     ( CORETSE_AHB_0_AHBMRX_HRDATA ),
        .HRESP_M3      (  ),
        .HRDATA_M3     (  ),
        .HADDR_S0      (  ),
        .HSIZE_S0      (  ),
        .HTRANS_S0     (  ),
        .HWDATA_S0     (  ),
        .HBURST_S0     (  ),
        .HPROT_S0      (  ),
        .HADDR_S1      (  ),
        .HSIZE_S1      (  ),
        .HTRANS_S1     (  ),
        .HWDATA_S1     (  ),
        .HBURST_S1     (  ),
        .HPROT_S1      (  ),
        .HADDR_S2      ( CoreAHBLite_0_AHBmslave2_HADDR ),
        .HSIZE_S2      ( CoreAHBLite_0_AHBmslave2_HSIZE ),
        .HTRANS_S2     ( CoreAHBLite_0_AHBmslave2_HTRANS ),
        .HWDATA_S2     ( CoreAHBLite_0_AHBmslave2_HWDATA ),
        .HBURST_S2     ( CoreAHBLite_0_AHBmslave2_HBURST ),
        .HPROT_S2      ( CoreAHBLite_0_AHBmslave2_HPROT ),
        .HADDR_S3      ( CoreAHBLite_0_AHBmslave3_HADDR ),
        .HSIZE_S3      ( CoreAHBLite_0_AHBmslave3_HSIZE ),
        .HTRANS_S3     ( CoreAHBLite_0_AHBmslave3_HTRANS ),
        .HWDATA_S3     ( CoreAHBLite_0_AHBmslave3_HWDATA ),
        .HBURST_S3     ( CoreAHBLite_0_AHBmslave3_HBURST ),
        .HPROT_S3      ( CoreAHBLite_0_AHBmslave3_HPROT ),
        .HADDR_S4      (  ),
        .HSIZE_S4      (  ),
        .HTRANS_S4     (  ),
        .HWDATA_S4     (  ),
        .HBURST_S4     (  ),
        .HPROT_S4      (  ),
        .HADDR_S5      (  ),
        .HSIZE_S5      (  ),
        .HTRANS_S5     (  ),
        .HWDATA_S5     (  ),
        .HBURST_S5     (  ),
        .HPROT_S5      (  ),
        .HADDR_S6      (  ),
        .HSIZE_S6      (  ),
        .HTRANS_S6     (  ),
        .HWDATA_S6     (  ),
        .HBURST_S6     (  ),
        .HPROT_S6      (  ),
        .HADDR_S7      (  ),
        .HSIZE_S7      (  ),
        .HTRANS_S7     (  ),
        .HWDATA_S7     (  ),
        .HBURST_S7     (  ),
        .HPROT_S7      (  ),
        .HADDR_S8      (  ),
        .HSIZE_S8      (  ),
        .HTRANS_S8     (  ),
        .HWDATA_S8     (  ),
        .HBURST_S8     (  ),
        .HPROT_S8      (  ),
        .HADDR_S9      (  ),
        .HSIZE_S9      (  ),
        .HTRANS_S9     (  ),
        .HWDATA_S9     (  ),
        .HBURST_S9     (  ),
        .HPROT_S9      (  ),
        .HADDR_S10     (  ),
        .HSIZE_S10     (  ),
        .HTRANS_S10    (  ),
        .HWDATA_S10    (  ),
        .HBURST_S10    (  ),
        .HPROT_S10     (  ),
        .HADDR_S11     (  ),
        .HSIZE_S11     (  ),
        .HTRANS_S11    (  ),
        .HWDATA_S11    (  ),
        .HBURST_S11    (  ),
        .HPROT_S11     (  ),
        .HADDR_S12     (  ),
        .HSIZE_S12     (  ),
        .HTRANS_S12    (  ),
        .HWDATA_S12    (  ),
        .HBURST_S12    (  ),
        .HPROT_S12     (  ),
        .HADDR_S13     (  ),
        .HSIZE_S13     (  ),
        .HTRANS_S13    (  ),
        .HWDATA_S13    (  ),
        .HBURST_S13    (  ),
        .HPROT_S13     (  ),
        .HADDR_S14     (  ),
        .HSIZE_S14     (  ),
        .HTRANS_S14    (  ),
        .HWDATA_S14    (  ),
        .HBURST_S14    (  ),
        .HPROT_S14     (  ),
        .HADDR_S15     (  ),
        .HSIZE_S15     (  ),
        .HTRANS_S15    (  ),
        .HWDATA_S15    (  ),
        .HBURST_S15    (  ),
        .HPROT_S15     (  ),
        .HADDR_S16     (  ),
        .HSIZE_S16     (  ),
        .HTRANS_S16    (  ),
        .HWDATA_S16    (  ),
        .HBURST_S16    (  ),
        .HPROT_S16     (  ) 
        );

//--------CoreConfigP   -   Actel:DirectCore:CoreConfigP:7.1.100
CoreConfigP #( 
        .DEVICE_090         ( 1 ),
        .ENABLE_SOFT_RESETS ( 0 ),
        .FDDR_IN_USE        ( 0 ),
        .MDDR_IN_USE        ( 0 ),
        .SDIF0_IN_USE       ( 1 ),
        .SDIF0_PCIE         ( 0 ),
        .SDIF1_IN_USE       ( 0 ),
        .SDIF1_PCIE         ( 0 ),
        .SDIF2_IN_USE       ( 0 ),
        .SDIF2_PCIE         ( 0 ),
        .SDIF3_IN_USE       ( 0 ),
        .SDIF3_PCIE         ( 0 ) )
CoreConfigP_0(
        // Inputs
        .FIC_2_APB_M_PRESET_N           ( CoreTSE_Webserver_MSS_0_FIC_2_APB_M_PRESET_N ),
        .FIC_2_APB_M_PCLK               ( CoreTSE_Webserver_MSS_0_FIC_2_APB_M_PCLK ),
        .SDIF_RELEASED                  ( CoreResetP_0_SDIF_RELEASED ),
        .INIT_DONE                      ( CoreResetP_0_INIT_DONE ),
        .FIC_2_APB_M_PSEL               ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PSELx ),
        .FIC_2_APB_M_PENABLE            ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PENABLE ),
        .FIC_2_APB_M_PWRITE             ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PWRITE ),
        .MDDR_PREADY                    ( VCC_net ), // tied to 1'b1 from definition
        .MDDR_PSLVERR                   ( GND_net ), // tied to 1'b0 from definition
        .FDDR_PREADY                    ( VCC_net ), // tied to 1'b1 from definition
        .FDDR_PSLVERR                   ( GND_net ), // tied to 1'b0 from definition
        .SDIF0_PREADY                   ( CoreConfigP_0_SDIF0_APBmslave_PREADY ),
        .SDIF0_PSLVERR                  ( CoreConfigP_0_SDIF0_APBmslave_PSLVERR ),
        .SDIF1_PREADY                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF1_PSLVERR                  ( GND_net ), // tied to 1'b0 from definition
        .SDIF2_PREADY                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF2_PSLVERR                  ( GND_net ), // tied to 1'b0 from definition
        .SDIF3_PREADY                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF3_PSLVERR                  ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_APB_M_PADDR              ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR_0 ),
        .FIC_2_APB_M_PWDATA             ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PWDATA ),
        .MDDR_PRDATA                    ( MDDR_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .FDDR_PRDATA                    ( FDDR_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SDIF0_PRDATA                   ( CoreConfigP_0_SDIF0_APBmslave_PRDATA ),
        .SDIF1_PRDATA                   ( SDIF1_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SDIF2_PRDATA                   ( SDIF2_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SDIF3_PRDATA                   ( SDIF3_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        // Outputs
        .APB_S_PCLK                     ( CoreConfigP_0_APB_S_PCLK ),
        .APB_S_PRESET_N                 ( CoreConfigP_0_APB_S_PRESET_N ),
        .CONFIG1_DONE                   ( CoreConfigP_0_CONFIG1_DONE ),
        .CONFIG2_DONE                   ( CoreConfigP_0_CONFIG2_DONE ),
        .FIC_2_APB_M_PREADY             ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PREADY ),
        .FIC_2_APB_M_PSLVERR            ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PSLVERR ),
        .MDDR_PSEL                      (  ),
        .MDDR_PENABLE                   (  ),
        .MDDR_PWRITE                    (  ),
        .FDDR_PSEL                      (  ),
        .FDDR_PENABLE                   (  ),
        .FDDR_PWRITE                    (  ),
        .SDIF0_PSEL                     ( CoreConfigP_0_SDIF0_APBmslave_PSELx ),
        .SDIF0_PENABLE                  ( CoreConfigP_0_SDIF0_APBmslave_PENABLE ),
        .SDIF0_PWRITE                   ( CoreConfigP_0_SDIF0_APBmslave_PWRITE ),
        .SDIF1_PSEL                     (  ),
        .SDIF1_PENABLE                  (  ),
        .SDIF1_PWRITE                   (  ),
        .SDIF2_PSEL                     (  ),
        .SDIF2_PENABLE                  (  ),
        .SDIF2_PWRITE                   (  ),
        .SDIF3_PSEL                     (  ),
        .SDIF3_PENABLE                  (  ),
        .SDIF3_PWRITE                   (  ),
        .SOFT_EXT_RESET_OUT             (  ),
        .SOFT_RESET_F2M                 (  ),
        .SOFT_M3_RESET                  (  ),
        .SOFT_MDDR_DDR_AXI_S_CORE_RESET (  ),
        .SOFT_FDDR_CORE_RESET           (  ),
        .SOFT_SDIF0_PHY_RESET           (  ),
        .SOFT_SDIF0_CORE_RESET          (  ),
        .SOFT_SDIF0_0_CORE_RESET        (  ),
        .SOFT_SDIF0_1_CORE_RESET        (  ),
        .SOFT_SDIF1_PHY_RESET           (  ),
        .SOFT_SDIF1_CORE_RESET          (  ),
        .SOFT_SDIF2_PHY_RESET           (  ),
        .SOFT_SDIF2_CORE_RESET          (  ),
        .SOFT_SDIF3_PHY_RESET           (  ),
        .SOFT_SDIF3_CORE_RESET          (  ),
        .R_SDIF0_PSEL                   (  ),
        .R_SDIF0_PWRITE                 (  ),
        .R_SDIF1_PSEL                   (  ),
        .R_SDIF1_PWRITE                 (  ),
        .R_SDIF2_PSEL                   (  ),
        .R_SDIF2_PWRITE                 (  ),
        .R_SDIF3_PSEL                   (  ),
        .R_SDIF3_PWRITE                 (  ),
        .FIC_2_APB_M_PRDATA             ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PRDATA ),
        .MDDR_PADDR                     (  ),
        .MDDR_PWDATA                    (  ),
        .FDDR_PADDR                     (  ),
        .FDDR_PWDATA                    (  ),
        .SDIF0_PADDR                    ( CoreConfigP_0_SDIF0_APBmslave_PADDR ),
        .SDIF0_PWDATA                   ( CoreConfigP_0_SDIF0_APBmslave_PWDATA ),
        .SDIF1_PADDR                    (  ),
        .SDIF1_PWDATA                   (  ),
        .SDIF2_PADDR                    (  ),
        .SDIF2_PWDATA                   (  ),
        .SDIF3_PADDR                    (  ),
        .SDIF3_PWDATA                   (  ),
        .R_SDIF0_PRDATA                 (  ),
        .R_SDIF1_PRDATA                 (  ),
        .R_SDIF2_PRDATA                 (  ),
        .R_SDIF3_PRDATA                 (  ) 
        );

//--------CoreResetP   -   Actel:DirectCore:CoreResetP:7.1.100
CoreResetP #( 
        .DDR_WAIT            ( 200 ),
        .DEVICE_090          ( 1 ),
        .DEVICE_VOLTAGE      ( 2 ),
        .ENABLE_SOFT_RESETS  ( 0 ),
        .EXT_RESET_CFG       ( 0 ),
        .FDDR_IN_USE         ( 0 ),
        .MDDR_IN_USE         ( 0 ),
        .SDIF0_IN_USE        ( 1 ),
        .SDIF0_PCIE          ( 0 ),
        .SDIF0_PCIE_HOTRESET ( 1 ),
        .SDIF0_PCIE_L2P2     ( 1 ),
        .SDIF1_IN_USE        ( 0 ),
        .SDIF1_PCIE          ( 0 ),
        .SDIF1_PCIE_HOTRESET ( 1 ),
        .SDIF1_PCIE_L2P2     ( 1 ),
        .SDIF2_IN_USE        ( 0 ),
        .SDIF2_PCIE          ( 0 ),
        .SDIF2_PCIE_HOTRESET ( 1 ),
        .SDIF2_PCIE_L2P2     ( 1 ),
        .SDIF3_IN_USE        ( 0 ),
        .SDIF3_PCIE          ( 0 ),
        .SDIF3_PCIE_HOTRESET ( 1 ),
        .SDIF3_PCIE_L2P2     ( 1 ) )
CoreResetP_0(
        // Inputs
        .RESET_N_M2F                    ( CoreTSE_Webserver_MSS_0_MSS_RESET_N_M2F ),
        .FIC_2_APB_M_PRESET_N           ( CoreTSE_Webserver_MSS_0_FIC_2_APB_M_PRESET_N ),
        .POWER_ON_RESET_N               ( SYSRESET_0_POWER_ON_RESET_N ),
        .FAB_RESET_N                    ( VCC_net ),
        .RCOSC_25_50MHZ                 ( OSC_0_RCOSC_25_50MHZ_O2F ),
        .CLK_BASE                       ( FCCC_0_GL0 ),
        .CLK_LTSSM                      ( GND_net ), // tied to 1'b0 from definition
        .FPLL_LOCK                      ( VCC_net ), // tied to 1'b1 from definition
        .SDIF0_SPLL_LOCK                ( VCC_net ),
        .SDIF1_SPLL_LOCK                ( VCC_net ), // tied to 1'b1 from definition
        .SDIF2_SPLL_LOCK                ( VCC_net ), // tied to 1'b1 from definition
        .SDIF3_SPLL_LOCK                ( VCC_net ), // tied to 1'b1 from definition
        .CONFIG1_DONE                   ( CoreConfigP_0_CONFIG1_DONE ),
        .CONFIG2_DONE                   ( CoreConfigP_0_CONFIG2_DONE ),
        .SDIF0_PERST_N                  ( VCC_net ), // tied to 1'b1 from definition
        .SDIF1_PERST_N                  ( VCC_net ), // tied to 1'b1 from definition
        .SDIF2_PERST_N                  ( VCC_net ), // tied to 1'b1 from definition
        .SDIF3_PERST_N                  ( VCC_net ), // tied to 1'b1 from definition
        .SDIF0_PSEL                     ( GND_net ), // tied to 1'b0 from definition
        .SDIF0_PWRITE                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF1_PSEL                     ( GND_net ), // tied to 1'b0 from definition
        .SDIF1_PWRITE                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF2_PSEL                     ( GND_net ), // tied to 1'b0 from definition
        .SDIF2_PWRITE                   ( VCC_net ), // tied to 1'b1 from definition
        .SDIF3_PSEL                     ( GND_net ), // tied to 1'b0 from definition
        .SDIF3_PWRITE                   ( VCC_net ), // tied to 1'b1 from definition
        .SOFT_EXT_RESET_OUT             ( GND_net ), // tied to 1'b0 from definition
        .SOFT_RESET_F2M                 ( GND_net ), // tied to 1'b0 from definition
        .SOFT_M3_RESET                  ( GND_net ), // tied to 1'b0 from definition
        .SOFT_MDDR_DDR_AXI_S_CORE_RESET ( GND_net ), // tied to 1'b0 from definition
        .SOFT_FDDR_CORE_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF0_PHY_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF0_CORE_RESET          ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF0_0_CORE_RESET        ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF0_1_CORE_RESET        ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF1_PHY_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF1_CORE_RESET          ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF2_PHY_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF2_CORE_RESET          ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF3_PHY_RESET           ( GND_net ), // tied to 1'b0 from definition
        .SOFT_SDIF3_CORE_RESET          ( GND_net ), // tied to 1'b0 from definition
        .SDIF0_PRDATA                   ( SDIF0_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SDIF1_PRDATA                   ( SDIF1_PRDATA_const_net_1 ), // tied to 32'h00000000 from definition
        .SDIF2_PRDATA                   ( SDIF2_PRDATA_const_net_1 ), // tied to 32'h00000000 from definition
        .SDIF3_PRDATA                   ( SDIF3_PRDATA_const_net_1 ), // tied to 32'h00000000 from definition
        // Outputs
        .MSS_HPMS_READY                 ( CoreResetP_0_MSS_HPMS_READY ),
        .DDR_READY                      (  ),
        .SDIF_READY                     (  ),
        .RESET_N_F2M                    ( CoreResetP_0_RESET_N_F2M ),
        .M3_RESET_N                     ( CoreResetP_0_M3_RESET_N ),
        .EXT_RESET_OUT                  (  ),
        .MDDR_DDR_AXI_S_CORE_RESET_N    (  ),
        .FDDR_CORE_RESET_N              (  ),
        .SDIF0_CORE_RESET_N             (  ),
        .SDIF0_0_CORE_RESET_N           (  ),
        .SDIF0_1_CORE_RESET_N           (  ),
        .SDIF0_PHY_RESET_N              ( CoreResetP_0_SDIF0_PHY_RESET_N ),
        .SDIF1_CORE_RESET_N             (  ),
        .SDIF1_PHY_RESET_N              (  ),
        .SDIF2_CORE_RESET_N             (  ),
        .SDIF2_PHY_RESET_N              (  ),
        .SDIF3_CORE_RESET_N             (  ),
        .SDIF3_PHY_RESET_N              (  ),
        .SDIF_RELEASED                  ( CoreResetP_0_SDIF_RELEASED ),
        .INIT_DONE                      ( CoreResetP_0_INIT_DONE ) 
        );

//--------CoreTSE_Webserver_CORETSE_AHB_0_CORETSE_AHB   -   Actel:DirectCore:CORETSE_AHB:2.1.105
CoreTSE_Webserver_CORETSE_AHB_0_CORETSE_AHB #( 
        .FAMILY      ( 19 ),
        .GMII_TBI    ( 1 ),
        .MDIO_PHYID  ( 18 ),
        .PACKET_SIZE ( 11 ),
        .SAL         ( 1 ),
        .STATS       ( 1 ),
        .WOL         ( 1 ) )
CORETSE_AHB_0(
        // Inputs
        .STBP          ( GND_net ),
        .TXCLK         ( FCCC_3_GL1 ),
        .RXCLK         ( FCCC_3_GL1 ),
        .GTXCLK        ( FCCC_2_GL0 ),
        .PMARX_CLK0    ( FCCC_1_GL0 ),
        .PMARX_CLK1    ( FCCC_1_GL1 ),
        .RXDV          ( GND_net ), // tied to 1'b0 from definition
        .RXER          ( GND_net ), // tied to 1'b0 from definition
        .CRS           ( GND_net ), // tied to 1'b0 from definition
        .COL           ( GND_net ), // tied to 1'b0 from definition
        .HRESETN       ( CoreResetP_0_MSS_HPMS_READY ),
        .HCLK          ( FCCC_0_GL0 ),
        .HREADY        ( CoreAHBLite_0_AHBmslave3_HREADY ),
        .HSEL          ( CoreAHBLite_0_AHBmslave3_HSELx ),
        .HWRITE        ( CoreAHBLite_0_AHBmslave3_HWRITE ),
        .HMASTLOCK     ( CoreAHBLite_0_AHBmslave3_HMASTLOCK ),
        .TXHGRANT      ( VCC_net ), // tied to 1'b1 from definition
        .TXHREADY      ( CORETSE_AHB_0_AHBMTX_HREADY ),
        .RXHGRANT      ( VCC_net ), // tied to 1'b1 from definition
        .RXHREADY      ( CORETSE_AHB_0_AHBMRX_HREADY ),
        .MDI           ( BIBUF_0_Y ),
        .TBI_READY     ( SERDES_IF2_0_EPCS_3_READY ),
        .SIGNAL_DETECT ( VCC_net ),
        .RCG           ( SERDES_IF2_0_EPCS_3_RX_DATA ),
        .RXD           ( RXD_const_net_0 ), // tied to 8'h00 from definition
        .HWDATA        ( CoreAHBLite_0_AHBmslave3_HWDATA ),
        .HADDR         ( CoreAHBLite_0_AHBmslave3_HADDR ),
        .HTRANS        ( CoreAHBLite_0_AHBmslave3_HTRANS ),
        .HBURST        ( CoreAHBLite_0_AHBmslave3_HBURST ),
        .HSIZE         ( CoreAHBLite_0_AHBmslave3_HSIZE ),
        .TXHRESP       ( CORETSE_AHB_0_AHBMTX_HRESP ),
        .TXHRDATA      ( CORETSE_AHB_0_AHBMTX_HRDATA ),
        .RXHRESP       ( CORETSE_AHB_0_AHBMRX_HRESP ),
        .RXHRDATA      ( CORETSE_AHB_0_AHBMRX_HRDATA ),
        // Outputs
        .TXEN          (  ),
        .TXER          (  ),
        .HREADYOUT     ( CoreAHBLite_0_AHBmslave3_HREADYOUT ),
        .TXHBUSREQ     ( CORETSE_AHB_0_AHBMTX_HBUSREQ ),
        .TXHWRITE      ( CORETSE_AHB_0_AHBMTX_HWRITE ),
        .RXHBUSREQ     ( CORETSE_AHB_0_AHBMRX_HBUSREQ ),
        .RXHWRITE      ( CORETSE_AHB_0_AHBMRX_HWRITE ),
        .TXHLOCK       ( CORETSE_AHB_0_AHBMTX_HLOCK ),
        .RXHLOCK       ( CORETSE_AHB_0_AHBMRX_HLOCK ),
        .MDC           ( PHY_MDC_net_0 ),
        .MDO           ( CORETSE_AHB_0_MDO ),
        .MDOEN         ( CORETSE_AHB_0_MDOEN ),
        .TBI_TXVAL     ( CORETSE_AHB_0_TBI_TXVAL ),
        .SYNC          (  ),
        .TCG           ( CORETSE_AHB_0_TCG ),
        .TXD           (  ),
        .HRDATA        ( CoreAHBLite_0_AHBmslave3_HRDATA ),
        .HRESP         ( CoreAHBLite_0_AHBmslave3_HRESP ),
        .TXHTRANS      ( CORETSE_AHB_0_AHBMTX_HTRANS ),
        .TXHADDR       ( CORETSE_AHB_0_AHBMTX_HADDR ),
        .TXHWDATA      ( CORETSE_AHB_0_AHBMTX_HWDATA ),
        .RXHTRANS      ( CORETSE_AHB_0_AHBMRX_HTRANS ),
        .RXHADDR       ( CORETSE_AHB_0_AHBMRX_HADDR ),
        .RXHWDATA      ( CORETSE_AHB_0_AHBMRX_HWDATA ),
        .TXHBURST      ( CORETSE_AHB_0_AHBMTX_HBURST ),
        .RXHBURST      ( CORETSE_AHB_0_AHBMRX_HBURST ),
        .TXHSIZE       ( CORETSE_AHB_0_AHBMTX_HSIZE ),
        .RXHSIZE       ( CORETSE_AHB_0_AHBMRX_HSIZE ),
        .TSM_CONTROL   ( TSM_CONTROL_net_0 ),
        .TSM_INTR      ( TSM_INTR_net_0 ),
        .ANX_STATE     (  ) 
        );

//--------CoreTSE_Webserver_MSS
CoreTSE_Webserver_MSS CoreTSE_Webserver_MSS_0(
        // Inputs
        .SPI_0_DI               ( SPI_0_DI ),
        .SPI_1_DI               ( SPI_1_DI ),
        .MCCC_CLK_BASE          ( FCCC_0_GL0 ),
        .MMUART_1_RXD           ( MMUART_1_RXD ),
        .FIC_2_APB_M_PREADY     ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PREADY ),
        .FIC_2_APB_M_PSLVERR    ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PSLVERR ),
        .FIC_0_AHB_S_HREADY     ( CoreAHBLite_0_AHBmslave2_HREADY ),
        .FIC_0_AHB_S_HWRITE     ( CoreAHBLite_0_AHBmslave2_HWRITE ),
        .FIC_0_AHB_S_HMASTLOCK  ( CoreAHBLite_0_AHBmslave2_HMASTLOCK ),
        .FIC_0_AHB_S_HSEL       ( CoreAHBLite_0_AHBmslave2_HSELx ),
        .FIC_0_AHB_M_HREADY     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HREADY ),
        .FIC_0_AHB_M_HRESP      ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRESP_0 ),
        .MCCC_CLK_BASE_PLL_LOCK ( FCCC_0_LOCK ),
        .MSS_RESET_N_F2M        ( CoreResetP_0_RESET_N_F2M ),
        .M3_RESET_N             ( CoreResetP_0_M3_RESET_N ),
        .FIC_2_APB_M_PRDATA     ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PRDATA ),
        .FIC_0_AHB_S_HADDR      ( CoreAHBLite_0_AHBmslave2_HADDR ),
        .FIC_0_AHB_S_HWDATA     ( CoreAHBLite_0_AHBmslave2_HWDATA ),
        .FIC_0_AHB_S_HSIZE      ( CoreAHBLite_0_AHBmslave2_HSIZE_0 ),
        .FIC_0_AHB_S_HTRANS     ( CoreAHBLite_0_AHBmslave2_HTRANS ),
        .FIC_0_AHB_M_HRDATA     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HRDATA ),
        .MSS_INT_F2M            ( MSS_INT_F2M_net_0 ),
        // Outputs
        .SPI_0_DO               ( SPI_0_DO_net_0 ),
        .SPI_1_DO               ( SPI_1_DO_net_0 ),
        .MMUART_1_TXD           ( MMUART_1_TXD_net_0 ),
        .GPIO_0_M2F             ( GPIO_0_M2F_net_0 ),
        .GPIO_1_M2F             ( GPIO_1_M2F_net_0 ),
        .GPIO_2_M2F             ( GPIO_2_M2F_net_0 ),
        .GPIO_3_M2F             ( GPIO_3_M2F_net_0 ),
        .GPIO_4_M2F             ( GPIO_4_M2F_net_0 ),
        .GPIO_5_M2F             ( GPIO_5_M2F_net_0 ),
        .GPIO_6_M2F             ( GPIO_6_M2F_net_0 ),
        .GPIO_7_M2F             ( GPIO_7_M2F_net_0 ),
        .FIC_2_APB_M_PRESET_N   ( CoreTSE_Webserver_MSS_0_FIC_2_APB_M_PRESET_N ),
        .FIC_2_APB_M_PCLK       ( CoreTSE_Webserver_MSS_0_FIC_2_APB_M_PCLK ),
        .FIC_2_APB_M_PWRITE     ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PWRITE ),
        .FIC_2_APB_M_PENABLE    ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PENABLE ),
        .FIC_2_APB_M_PSEL       ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PSELx ),
        .FIC_0_AHB_S_HRESP      ( CoreAHBLite_0_AHBmslave2_HRESP ),
        .FIC_0_AHB_S_HREADYOUT  ( CoreAHBLite_0_AHBmslave2_HREADYOUT ),
        .FIC_0_AHB_M_HWRITE     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HWRITE ),
        .MSS_RESET_N_M2F        ( CoreTSE_Webserver_MSS_0_MSS_RESET_N_M2F ),
        .FIC_2_APB_M_PADDR      ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PADDR ),
        .FIC_2_APB_M_PWDATA     ( CoreTSE_Webserver_MSS_0_FIC_2_APB_MASTER_PWDATA ),
        .FIC_0_AHB_S_HRDATA     ( CoreAHBLite_0_AHBmslave2_HRDATA ),
        .FIC_0_AHB_M_HADDR      ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HADDR ),
        .FIC_0_AHB_M_HWDATA     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HWDATA ),
        .FIC_0_AHB_M_HSIZE      ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HSIZE ),
        .FIC_0_AHB_M_HTRANS     ( CoreTSE_Webserver_MSS_0_FIC_0_AHB_MASTER_HTRANS ),
        // Inouts
        .SPI_0_CLK              ( SPI_0_CLK ),
        .SPI_0_SS0              ( SPI_0_SS0 ),
        .SPI_1_CLK              ( SPI_1_CLK ),
        .SPI_1_SS0              ( SPI_1_SS0 ) 
        );

//--------CoreTSE_Webserver_FCCC_0_FCCC   -   Actel:SgCore:FCCC:2.0.200
CoreTSE_Webserver_FCCC_0_FCCC FCCC_0(
        // Inputs
        .CLK1_PAD ( CLK1_PAD ),
        // Outputs
        .GL0      ( FCCC_0_GL0 ),
        .LOCK     ( FCCC_0_LOCK ) 
        );

//--------CoreTSE_Webserver_FCCC_1_FCCC   -   Actel:SgCore:FCCC:2.0.200
CoreTSE_Webserver_FCCC_1_FCCC FCCC_1(
        // Inputs
        .CLK0 ( SERDES_IF2_0_EPCS_3_RX_CLK ),
        // Outputs
        .GL0  ( FCCC_1_GL0 ),
        .GL1  ( FCCC_1_GL1 ),
        .LOCK ( FCCC_1_LOCK ) 
        );

//--------CoreTSE_Webserver_FCCC_2_FCCC   -   Actel:SgCore:FCCC:2.0.200
CoreTSE_Webserver_FCCC_2_FCCC FCCC_2(
        // Inputs
        .CLK0 ( SERDES_IF2_0_EPCS_3_TX_CLK ),
        // Outputs
        .GL0  ( FCCC_2_GL0 ),
        .LOCK ( FCCC_2_LOCK ) 
        );

//--------CoreTSE_Webserver_FCCC_3_FCCC   -   Actel:SgCore:FCCC:2.0.200
CoreTSE_Webserver_FCCC_3_FCCC FCCC_3(
        // Inputs
        .CLK0          ( SERDES_IF2_0_EPCS_3_TX_CLK ),
        .CLK1          ( FCCC_3_GL0 ),
        .NGMUX0_SEL    ( CORETSE_AHB_0_TSM_CONTROL0to0 ),
        .NGMUX1_SEL    ( CORETSE_AHB_0_TSM_CONTROL1to1 ),
        .NGMUX0_HOLD_N ( VCC_net ),
        .NGMUX1_HOLD_N ( VCC_net ),
        .NGMUX0_ARST_N ( PHY_RST_net_0 ),
        .NGMUX1_ARST_N ( PHY_RST_net_0 ),
        // Outputs
        .GL0           ( FCCC_3_GL0 ),
        .GL1           ( FCCC_3_GL1 ),
        .LOCK          (  ) 
        );

//--------CoreTSE_Webserver_OSC_0_OSC   -   Actel:SgCore:OSC:2.0.101
CoreTSE_Webserver_OSC_0_OSC OSC_0(
        // Inputs
        .XTL                ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .RCOSC_25_50MHZ_CCC (  ),
        .RCOSC_25_50MHZ_O2F ( OSC_0_RCOSC_25_50MHZ_O2F ),
        .RCOSC_1MHZ_CCC     (  ),
        .RCOSC_1MHZ_O2F     (  ),
        .XTLOSC_CCC         (  ),
        .XTLOSC_O2F         (  ) 
        );

//--------CoreTSE_Webserver_SERDES_IF2_0_SERDES_IF2   -   Actel:SgCore:SERDES_IF2:1.2.212
CoreTSE_Webserver_SERDES_IF2_0_SERDES_IF2 SERDES_IF2_0(
        // Inputs
        .EPCS_3_PWRDN         ( GND_net ),
        .EPCS_3_TX_VAL        ( CORETSE_AHB_0_TBI_TXVAL ),
        .EPCS_3_TX_OOB        ( GND_net ),
        .EPCS_3_RX_ERR        ( GND_net ),
        .EPCS_3_RESET_N       ( CoreResetP_0_SDIF0_PHY_RESET_N ),
        .APB_S_PENABLE        ( CoreConfigP_0_SDIF0_APBmslave_PENABLE ),
        .APB_S_PSEL           ( CoreConfigP_0_SDIF0_APBmslave_PSELx ),
        .APB_S_PWRITE         ( CoreConfigP_0_SDIF0_APBmslave_PWRITE ),
        .APB_S_PRESET_N       ( CoreConfigP_0_APB_S_PRESET_N ),
        .APB_S_PCLK           ( CoreConfigP_0_APB_S_PCLK ),
        .REFCLK1_P            ( REFCLK1_P ),
        .REFCLK1_N            ( REFCLK1_N ),
        .RXD0_P               ( RXD0_P ),
        .RXD0_N               ( RXD0_N ),
        .RXD1_P               ( RXD1_P ),
        .RXD1_N               ( RXD1_N ),
        .RXD2_P               ( RXD2_P ),
        .RXD2_N               ( RXD2_N ),
        .RXD3_P               ( RXD3_P ),
        .RXD3_N               ( RXD3_N ),
        .EPCS_3_TX_DATA       ( CORETSE_AHB_0_TCG ),
        .APB_S_PADDR          ( CoreConfigP_0_SDIF0_APBmslave_PADDR_0 ),
        .APB_S_PWDATA         ( CoreConfigP_0_SDIF0_APBmslave_PWDATA ),
        // Outputs
        .EPCS_3_READY         ( SERDES_IF2_0_EPCS_3_READY ),
        .EPCS_3_RX_VAL        (  ),
        .EPCS_3_RX_IDLE       (  ),
        .EPCS_3_TX_CLK_STABLE (  ),
        .EPCS_3_RX_RESET_N    (  ),
        .EPCS_3_TX_RESET_N    (  ),
        .EPCS_3_RX_CLK        ( SERDES_IF2_0_EPCS_3_RX_CLK ),
        .EPCS_3_TX_CLK        ( SERDES_IF2_0_EPCS_3_TX_CLK ),
        .APB_S_PREADY         ( CoreConfigP_0_SDIF0_APBmslave_PREADY ),
        .APB_S_PSLVERR        ( CoreConfigP_0_SDIF0_APBmslave_PSLVERR ),
        .REFCLK1_OUT          (  ),
        .TXD0_P               ( TXD0_P_net_0 ),
        .TXD0_N               ( TXD0_N_net_0 ),
        .TXD1_P               ( TXD1_P_net_0 ),
        .TXD1_N               ( TXD1_N_net_0 ),
        .TXD2_P               ( TXD2_P_net_0 ),
        .TXD2_N               ( TXD2_N_net_0 ),
        .TXD3_P               ( TXD3_P_net_0 ),
        .TXD3_N               ( TXD3_N_net_0 ),
        .EPCS_3_RX_DATA       ( SERDES_IF2_0_EPCS_3_RX_DATA ),
        .APB_S_PRDATA         ( CoreConfigP_0_SDIF0_APBmslave_PRDATA ) 
        );

//--------SYSRESET
SYSRESET SYSRESET_0(
        // Inputs
        .DEVRST_N         ( DEVRST_N ),
        // Outputs
        .POWER_ON_RESET_N ( SYSRESET_0_POWER_ON_RESET_N ) 
        );


endmodule
