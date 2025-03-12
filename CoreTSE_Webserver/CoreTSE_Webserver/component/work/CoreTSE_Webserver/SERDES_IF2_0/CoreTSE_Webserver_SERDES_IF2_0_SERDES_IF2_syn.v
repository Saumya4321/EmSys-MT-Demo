`timescale 1 ns/100 ps
// Version: 


module SERDESIF_075(
       APB_PRDATA,
       APB_PREADY,
       APB_PSLVERR,
       ATXCLKSTABLE,
       EPCS_READY,
       EPCS_RXCLK,
       EPCS_RXCLK_0,
       EPCS_RXCLK_1,
       EPCS_RXDATA,
       EPCS_RXIDLE,
       EPCS_RXRSTN,
       EPCS_RXVAL,
       EPCS_TXCLK,
       EPCS_TXCLK_0,
       EPCS_TXCLK_1,
       EPCS_TXRSTN,
       FATC_RESET_N,
       H2FCALIB0,
       H2FCALIB1,
       M2_ARADDR,
       M2_ARBURST,
       M2_ARID,
       M2_ARLEN,
       M2_ARSIZE,
       M2_ARVALID,
       M2_AWADDR_HADDR,
       M2_AWBURST_HTRANS,
       M2_AWID,
       M2_AWLEN_HBURST,
       M2_AWSIZE_HSIZE,
       M2_AWVALID_HWRITE,
       M2_BREADY,
       M2_RREADY,
       M2_WDATA_HWDATA,
       M2_WID,
       M2_WLAST,
       M2_WSTRB,
       M2_WVALID,
       M_ARADDR,
       M_ARBURST,
       M_ARID,
       M_ARLEN,
       M_ARSIZE,
       M_ARVALID,
       M_AWADDR_HADDR,
       M_AWBURST_HTRANS,
       M_AWID,
       M_AWLEN_HBURST,
       M_AWSIZE_HSIZE,
       M_AWVALID_HWRITE,
       M_BREADY,
       M_RREADY,
       M_WDATA_HWDATA,
       M_WID,
       M_WLAST,
       M_WSTRB,
       M_WVALID,
       PCIE2_LTSSM,
       PCIE2_SYSTEM_INT,
       PCIE2_WAKE_N,
       PCIE_LTSSM,
       PCIE_SYSTEM_INT,
       PLL_LOCK_INT,
       PLL_LOCKLOST_INT,
       S2_ARREADY,
       S2_AWREADY,
       S2_BID,
       S2_BRESP_HRESP,
       S2_BVALID,
       S2_RDATA_HRDATA,
       S2_RID,
       S2_RLAST,
       S2_RRESP,
       S2_RVALID,
       S2_WREADY_HREADYOUT,
       S_ARREADY,
       S_AWREADY,
       S_BID,
       S_BRESP_HRESP,
       S_BVALID,
       S_RDATA_HRDATA,
       S_RID,
       S_RLAST,
       S_RRESP,
       S_RVALID,
       S_WREADY_HREADYOUT,
       SPLL_LOCK,
       WAKE_N,
       XAUI_OUT_CLK,
       APB_CLK,
       APB_PADDR,
       APB_PENABLE,
       APB_PSEL,
       APB_PWDATA,
       APB_PWRITE,
       APB_RSTN,
       CLK_BASE,
       EPCS_PWRDN,
       EPCS_RSTN,
       EPCS_RXERR,
       EPCS_TXDATA,
       EPCS_TXOOB,
       EPCS_TXVAL,
       F2HCALIB0,
       F2HCALIB1,
       FAB_PLL_LOCK,
       FAB_REF_CLK,
       M2_ARREADY,
       M2_AWREADY,
       M2_BID,
       M2_BRESP_HRESP,
       M2_BVALID,
       M2_RDATA_HRDATA,
       M2_RID,
       M2_RLAST,
       M2_RRESP,
       M2_RVALID,
       M2_WREADY_HREADY,
       M_ARREADY,
       M_AWREADY,
       M_BID,
       M_BRESP_HRESP,
       M_BVALID,
       M_RDATA_HRDATA,
       M_RID,
       M_RLAST,
       M_RRESP,
       M_RVALID,
       M_WREADY_HREADY,
       PCIE2_INTERRUPT,
       PCIE2_PERST_N,
       PCIE2_SERDESIF_CORE_RESET_N,
       PCIE2_WAKE_REQ,
       PCIE_INTERRUPT,
       PERST_N,
       S2_ARADDR,
       S2_ARBURST,
       S2_ARID,
       S2_ARLEN,
       S2_ARLOCK,
       S2_ARSIZE,
       S2_ARVALID,
       S2_AWADDR_HADDR,
       S2_AWBURST_HTRANS,
       S2_AWID_HSEL,
       S2_AWLEN_HBURST,
       S2_AWLOCK,
       S2_AWSIZE_HSIZE,
       S2_AWVALID_HWRITE,
       S2_BREADY_HREADY,
       S2_RREADY,
       S2_WDATA_HWDATA,
       S2_WID,
       S2_WLAST,
       S2_WSTRB,
       S2_WVALID,
       S_ARADDR,
       S_ARBURST,
       S_ARID,
       S_ARLEN,
       S_ARLOCK,
       S_ARSIZE,
       S_ARVALID,
       S_AWADDR_HADDR,
       S_AWBURST_HTRANS,
       S_AWID_HSEL,
       S_AWLEN_HBURST,
       S_AWLOCK,
       S_AWSIZE_HSIZE,
       S_AWVALID_HWRITE,
       S_BREADY_HREADY,
       S_RREADY,
       S_WDATA_HWDATA,
       S_WID,
       S_WLAST,
       S_WSTRB,
       S_WVALID,
       SERDESIF_CORE_RESET_N,
       SERDESIF_PHY_RESET_N,
       WAKE_REQ,
       XAUI_FB_CLK,
       RXD3_P,
       RXD2_P,
       RXD1_P,
       RXD0_P,
       RXD3_N,
       RXD2_N,
       RXD1_N,
       RXD0_N,
       TXD3_P,
       TXD2_P,
       TXD1_P,
       TXD0_P,
       TXD3_N,
       TXD2_N,
       TXD1_N,
       TXD0_N,
       REFCLK0,
       REFCLK1
    ) ;
/* synthesis syn_black_box

syn_tsu0 = " APB_PADDR[10]->APB_CLK = 3.791"
syn_tsu1 = " APB_PADDR[11]->APB_CLK = 3.498"
syn_tsu2 = " APB_PADDR[12]->APB_CLK = 3.309"
syn_tsu3 = " APB_PADDR[13]->APB_CLK = 3.076"
syn_tsu4 = " APB_PADDR[14]->APB_CLK = 2.521"
syn_tsu5 = " APB_PADDR[2]->APB_CLK = 2.929"
syn_tsu6 = " APB_PADDR[3]->APB_CLK = 3.244"
syn_tsu7 = " APB_PADDR[4]->APB_CLK = 2.893"
syn_tsu8 = " APB_PADDR[5]->APB_CLK = 3.29"
syn_tsu9 = " APB_PADDR[6]->APB_CLK = 2.853"
syn_tsu10 = " APB_PADDR[7]->APB_CLK = 2.851"
syn_tsu11 = " APB_PADDR[8]->APB_CLK = 3.48"
syn_tsu12 = " APB_PADDR[9]->APB_CLK = 3.473"
syn_tsu13 = " APB_PENABLE->APB_CLK = 0.833"
syn_tsu14 = " APB_PSEL->APB_CLK = 2.83"
syn_tsu15 = " APB_PWDATA[0]->APB_CLK = 1.294"
syn_tsu16 = " APB_PWDATA[10]->APB_CLK = 0.494"
syn_tsu17 = " APB_PWDATA[11]->APB_CLK = 0.581"
syn_tsu18 = " APB_PWDATA[12]->APB_CLK = 0.831"
syn_tsu19 = " APB_PWDATA[13]->APB_CLK = 0.725"
syn_tsu20 = " APB_PWDATA[14]->APB_CLK = 0.897"
syn_tsu21 = " APB_PWDATA[15]->APB_CLK = 0.713"
syn_tsu22 = " APB_PWDATA[16]->APB_CLK = 0.813"
syn_tsu23 = " APB_PWDATA[17]->APB_CLK = 0.747"
syn_tsu24 = " APB_PWDATA[18]->APB_CLK = 0.748"
syn_tsu25 = " APB_PWDATA[19]->APB_CLK = 0.954"
syn_tsu26 = " APB_PWDATA[1]->APB_CLK = 1.879"
syn_tsu27 = " APB_PWDATA[20]->APB_CLK = 0.803"
syn_tsu28 = " APB_PWDATA[21]->APB_CLK = 0.46"
syn_tsu29 = " APB_PWDATA[22]->APB_CLK = 0.516"
syn_tsu30 = " APB_PWDATA[23]->APB_CLK = 0.496"
syn_tsu31 = " APB_PWDATA[24]->APB_CLK = 0.642"
syn_tsu32 = " APB_PWDATA[25]->APB_CLK = 0.509"
syn_tsu33 = " APB_PWDATA[26]->APB_CLK = 0.421"
syn_tsu34 = " APB_PWDATA[27]->APB_CLK = 0.546"
syn_tsu35 = " APB_PWDATA[28]->APB_CLK = 0.087"
syn_tsu36 = " APB_PWDATA[29]->APB_CLK = 0"
syn_tsu37 = " APB_PWDATA[2]->APB_CLK = 1.743"
syn_tsu38 = " APB_PWDATA[30]->APB_CLK = 0.556"
syn_tsu39 = " APB_PWDATA[31]->APB_CLK = 0.054"
syn_tsu40 = " APB_PWDATA[3]->APB_CLK = 1.95"
syn_tsu41 = " APB_PWDATA[4]->APB_CLK = 1.925"
syn_tsu42 = " APB_PWDATA[5]->APB_CLK = 1.226"
syn_tsu43 = " APB_PWDATA[6]->APB_CLK = 1.954"
syn_tsu44 = " APB_PWDATA[7]->APB_CLK = 0.928"
syn_tsu45 = " APB_PWDATA[8]->APB_CLK = 0.693"
syn_tsu46 = " APB_PWDATA[9]->APB_CLK = 0.849"
syn_tsu47 = " APB_PWRITE->APB_CLK = 1.751"
syn_tco0 = " APB_CLK->APB_PRDATA[0] = 4.934"
syn_tco1 = " APB_CLK->APB_PRDATA[10] = 5.024"
syn_tco2 = " APB_CLK->APB_PRDATA[11] = 5.105"
syn_tco3 = " APB_CLK->APB_PRDATA[12] = 5.156"
syn_tco4 = " APB_CLK->APB_PRDATA[13] = 5.196"
syn_tco5 = " APB_CLK->APB_PRDATA[14] = 5.014"
syn_tco6 = " APB_CLK->APB_PRDATA[15] = 5.106"
syn_tco7 = " APB_CLK->APB_PRDATA[16] = 5.048"
syn_tco8 = " APB_CLK->APB_PRDATA[17] = 5.201"
syn_tco9 = " APB_CLK->APB_PRDATA[18] = 5.007"
syn_tco10 = " APB_CLK->APB_PRDATA[19] = 5.160"
syn_tco11 = " APB_CLK->APB_PRDATA[1] = 4.896"
syn_tco12 = " APB_CLK->APB_PRDATA[20] = 5.049"
syn_tco13 = " APB_CLK->APB_PRDATA[21] = 5.157"
syn_tco14 = " APB_CLK->APB_PRDATA[22] = 5.029"
syn_tco15 = " APB_CLK->APB_PRDATA[23] = 5.161"
syn_tco16 = " APB_CLK->APB_PRDATA[24] = 5.230"
syn_tco17 = " APB_CLK->APB_PRDATA[25] = 5.348"
syn_tco18 = " APB_CLK->APB_PRDATA[26] = 5.076"
syn_tco19 = " APB_CLK->APB_PRDATA[27] = 5.125"
syn_tco20 = " APB_CLK->APB_PRDATA[28] = 5.217"
syn_tco21 = " APB_CLK->APB_PRDATA[29] = 5.235"
syn_tco22 = " APB_CLK->APB_PRDATA[2] = 5.014"
syn_tco23 = " APB_CLK->APB_PRDATA[30] = 4.986"
syn_tco24 = " APB_CLK->APB_PRDATA[31] = 5.038"
syn_tco25 = " APB_CLK->APB_PRDATA[3] = 4.838"
syn_tco26 = " APB_CLK->APB_PRDATA[4] = 4.918"
syn_tco27 = " APB_CLK->APB_PRDATA[5] = 4.908"
syn_tco28 = " APB_CLK->APB_PRDATA[6] = 4.814"
syn_tco29 = " APB_CLK->APB_PRDATA[7] = 4.869"
syn_tco30 = " APB_CLK->APB_PRDATA[8] = 5.255"
syn_tco31 = " APB_CLK->APB_PRDATA[9] = 5.129"
syn_tco32 = " APB_CLK->APB_PREADY = 4.732"
syn_tco33 = " APB_CLK->APB_PSLVERR = 4.957"
syn_tco34 = " APB_CLK->PCIE2_SYSTEM_INT = 3.792"
syn_tco35 = " APB_CLK->PCIE_SYSTEM_INT = 4.040"
syn_tco36 = " APB_CLK->PLL_LOCKLOST_INT = 3.655"
syn_tco37 = " APB_CLK->PLL_LOCK_INT = 3.873"
syn_tco38 = " REFCLK1->ATXCLKSTABLE[0] = 3.215"
syn_tco39 = " REFCLK1->ATXCLKSTABLE[1] = 3.397"
*/
/* synthesis black_box_pad_pin ="RXD3_P,RXD2_P,RXD1_P,RXD0_P,RXD3_N,RXD2_N,RXD1_N,RXD0_N,TXD3_P,TXD2_P,TXD1_P,TXD0_P,TXD3_N,TXD2_N,TXD1_N,TXD0_N" */
output [31:0] APB_PRDATA;
output APB_PREADY;
output APB_PSLVERR;
output [1:0] ATXCLKSTABLE;
output [1:0] EPCS_READY;
output [1:0] EPCS_RXCLK;
output EPCS_RXCLK_0;
output EPCS_RXCLK_1;
output [39:0] EPCS_RXDATA;
output [1:0] EPCS_RXIDLE;
output [1:0] EPCS_RXRSTN;
output [1:0] EPCS_RXVAL;
output [1:0] EPCS_TXCLK;
output EPCS_TXCLK_0;
output EPCS_TXCLK_1;
output [1:0] EPCS_TXRSTN;
output FATC_RESET_N;
output H2FCALIB0;
output H2FCALIB1;
output [31:0] M2_ARADDR;
output [1:0] M2_ARBURST;
output [3:0] M2_ARID;
output [3:0] M2_ARLEN;
output [1:0] M2_ARSIZE;
output M2_ARVALID;
output [31:0] M2_AWADDR_HADDR;
output [1:0] M2_AWBURST_HTRANS;
output [3:0] M2_AWID;
output [3:0] M2_AWLEN_HBURST;
output [1:0] M2_AWSIZE_HSIZE;
output M2_AWVALID_HWRITE;
output M2_BREADY;
output M2_RREADY;
output [63:0] M2_WDATA_HWDATA;
output [3:0] M2_WID;
output M2_WLAST;
output [7:0] M2_WSTRB;
output M2_WVALID;
output [31:0] M_ARADDR;
output [1:0] M_ARBURST;
output [3:0] M_ARID;
output [3:0] M_ARLEN;
output [1:0] M_ARSIZE;
output M_ARVALID;
output [31:0] M_AWADDR_HADDR;
output [1:0] M_AWBURST_HTRANS;
output [3:0] M_AWID;
output [3:0] M_AWLEN_HBURST;
output [1:0] M_AWSIZE_HSIZE;
output M_AWVALID_HWRITE;
output M_BREADY;
output M_RREADY;
output [63:0] M_WDATA_HWDATA;
output [3:0] M_WID;
output M_WLAST;
output [7:0] M_WSTRB;
output M_WVALID;
output [5:0] PCIE2_LTSSM;
output PCIE2_SYSTEM_INT;
output PCIE2_WAKE_N;
output [5:0] PCIE_LTSSM;
output PCIE_SYSTEM_INT;
output PLL_LOCK_INT;
output PLL_LOCKLOST_INT;
output S2_ARREADY;
output S2_AWREADY;
output [3:0] S2_BID;
output [1:0] S2_BRESP_HRESP;
output S2_BVALID;
output [63:0] S2_RDATA_HRDATA;
output [3:0] S2_RID;
output S2_RLAST;
output [1:0] S2_RRESP;
output S2_RVALID;
output S2_WREADY_HREADYOUT;
output S_ARREADY;
output S_AWREADY;
output [3:0] S_BID;
output [1:0] S_BRESP_HRESP;
output S_BVALID;
output [63:0] S_RDATA_HRDATA;
output [3:0] S_RID;
output S_RLAST;
output [1:0] S_RRESP;
output S_RVALID;
output S_WREADY_HREADYOUT;
output SPLL_LOCK;
output WAKE_N;
output XAUI_OUT_CLK;
input  APB_CLK;
input  [14:2] APB_PADDR;
input  APB_PENABLE;
input  APB_PSEL;
input  [31:0] APB_PWDATA;
input  APB_PWRITE;
input  APB_RSTN;
input  CLK_BASE;
input  [1:0] EPCS_PWRDN;
input  [1:0] EPCS_RSTN;
input  [1:0] EPCS_RXERR;
input  [39:0] EPCS_TXDATA;
input  [1:0] EPCS_TXOOB;
input  [1:0] EPCS_TXVAL;
input  F2HCALIB0;
input  F2HCALIB1;
input  FAB_PLL_LOCK;
input  FAB_REF_CLK;
input  M2_ARREADY;
input  M2_AWREADY;
input  [3:0] M2_BID;
input  [1:0] M2_BRESP_HRESP;
input  M2_BVALID;
input  [63:0] M2_RDATA_HRDATA;
input  [3:0] M2_RID;
input  M2_RLAST;
input  [1:0] M2_RRESP;
input  M2_RVALID;
input  M2_WREADY_HREADY;
input  M_ARREADY;
input  M_AWREADY;
input  [3:0] M_BID;
input  [1:0] M_BRESP_HRESP;
input  M_BVALID;
input  [63:0] M_RDATA_HRDATA;
input  [3:0] M_RID;
input  M_RLAST;
input  [1:0] M_RRESP;
input  M_RVALID;
input  M_WREADY_HREADY;
input  [3:0] PCIE2_INTERRUPT;
input  PCIE2_PERST_N;
input  PCIE2_SERDESIF_CORE_RESET_N;
input  PCIE2_WAKE_REQ;
input  [3:0] PCIE_INTERRUPT;
input  PERST_N;
input  [31:0] S2_ARADDR;
input  [1:0] S2_ARBURST;
input  [3:0] S2_ARID;
input  [3:0] S2_ARLEN;
input  [1:0] S2_ARLOCK;
input  [1:0] S2_ARSIZE;
input  S2_ARVALID;
input  [31:0] S2_AWADDR_HADDR;
input  [1:0] S2_AWBURST_HTRANS;
input  [3:0] S2_AWID_HSEL;
input  [3:0] S2_AWLEN_HBURST;
input  [1:0] S2_AWLOCK;
input  [1:0] S2_AWSIZE_HSIZE;
input  S2_AWVALID_HWRITE;
input  S2_BREADY_HREADY;
input  S2_RREADY;
input  [63:0] S2_WDATA_HWDATA;
input  [3:0] S2_WID;
input  S2_WLAST;
input  [7:0] S2_WSTRB;
input  S2_WVALID;
input  [31:0] S_ARADDR;
input  [1:0] S_ARBURST;
input  [3:0] S_ARID;
input  [3:0] S_ARLEN;
input  [1:0] S_ARLOCK;
input  [1:0] S_ARSIZE;
input  S_ARVALID;
input  [31:0] S_AWADDR_HADDR;
input  [1:0] S_AWBURST_HTRANS;
input  [3:0] S_AWID_HSEL;
input  [3:0] S_AWLEN_HBURST;
input  [1:0] S_AWLOCK;
input  [1:0] S_AWSIZE_HSIZE;
input  S_AWVALID_HWRITE;
input  S_BREADY_HREADY;
input  S_RREADY;
input  [63:0] S_WDATA_HWDATA;
input  [3:0] S_WID;
input  S_WLAST;
input  [7:0] S_WSTRB;
input  S_WVALID;
input  SERDESIF_CORE_RESET_N;
input  SERDESIF_PHY_RESET_N;
input  WAKE_REQ;
input  XAUI_FB_CLK;
input  RXD3_P;
input  RXD2_P;
input  RXD1_P;
input  RXD0_P;
input  RXD3_N;
input  RXD2_N;
input  RXD1_N;
input  RXD0_N;
output TXD3_P;
output TXD2_P;
output TXD1_P;
output TXD0_P;
output TXD3_N;
output TXD2_N;
output TXD1_N;
output TXD0_N;
input  REFCLK0;
input  REFCLK1;
parameter INIT = 'h0;
parameter ACT_CONFIG = "";
parameter ACT_SIM = 0;

endmodule
