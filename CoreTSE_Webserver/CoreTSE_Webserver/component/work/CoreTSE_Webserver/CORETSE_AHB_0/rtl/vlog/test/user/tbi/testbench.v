//===========================================================================
//             MM     MM EEEEEE NN    N TTTTTTT  OOOO    RRRRR
//             M M   M M E      N N   N    T    O    O   R    R
//             M  M M  M EEEE   N  N  N    T    O    O   RRRRR
//             M   M   M E      N   N N    T    O    O   R   R
//             M       M EEEEEE N    NN    T     OOOO    R    R
//===========================================================================
// DESCRIPTION : PE-MCXMACAHB simulation fixture layer
// FILE        : $Source: /opt/cvs/dip/tsmac/top/vlogsim/sgmii_verif/pe_dmaTBI/sim_dual_TBI.v,v $
// REVISION    : $Revision: 1.4 $
// LAST UPDATE : $Date: 2014/01/31 10:19:40 $
//===========================================================================
//         Mentor Graphics Corporation Proprietary and Confidential
//         Copyright Mentor Graphics Corporation and Licensors 2004
//                         All Rights Reserved
//===========================================================================


`timescale 1ps / 1ps

// --------------------------------------------------------------------------
// -- Module Definition

module testbench (); 
// parameter FAMILY     = 19;
// parameter GMII_TBI          = 1;
// parameter TABITS              = 11;
// parameter RABITS              = 12;
// parameter MCXMAC_SAL_ON       = 1;
// parameter MCXMAC_WOL_ON       = 1;
// parameter MCXMAC_STATS_ON     = 1;

// --------------------------------------------------------------------------
// -- Internal Signal Declarations

`include "../../../../../coreparameters.v"

wire        tx_clk;    // MII Transmit Clock ( from external source )
wire        tx_clki;   // MII Transmit Clock, Input ( post clock tree )
wire        txceni;    // Transmit Clock Enable, Input ( post clock tree )
wire        rx_clk;    // MII Receive Clock  ( from external source )
wire        rx_clki;   // MII Receive Clock, Input  ( post clock tree )
wire        rxceni;    // Receive Clock Enable, Input  ( post clock tree )
wire        crs;       // MII Carrier Sense
wire        col;       // MII Collision
wire        mdi;       // MII Management Data Input
wire        rx_dv;     // G/MII Receive Data Valid
wire  [7:0] rxd;       // G/MII Receive Data
wire        rx_er;     // G/MII Receive Error
wire        rstbp;     // Reset Bypass
wire [31:0] ahb_hwdata;    // AHB write data
wire  [9:2] ahb_haddr;     // AHB address
wire        ahb_hsel;      // AHB slave select
wire  [1:0] ahb_htrans;    // AHB transaction type
wire        ahb_hwrite;    // AHB transaction direction
wire        ahb_txhgrant;    // AHB bus grant
wire        ahb_rxhgrant;    // AHB bus grant
wire  [1:0] ahb_txhrespm;     // AHB response
wire  [1:0] ahb_rxhrespm;     // AHB response
wire [31:0] ahb_txhrdatam;    // AHB read data
wire [31:0] ahb_rxhrdatam;    // AHB read data
wire        ahb_hreadyi;    // AHB ready
wire        hresetn;   // AHB system reset (active low)
wire        hclk;      // AHB system clock

wire        tx_clko;   // MII Transmit Clock, Output    ( pre-clock tree )
wire        txceno;    // Transmit Clock Enable, Output ( pre-clock tree )
wire        rx_clko;   // MII Receive Clock, Output     ( pre-clock tree )
wire        rxceno;    // Receive Clock Enable, Output  ( pre-clock tree )
wire        tx_en;     // G/MII Transmit Enable
wire  [7:0] txd;       // G/MII Transmit Data
wire        tx_er;     // G/MII Transmit Error
wire        mdc;       // MII Management Data Clock
wire        mdo;       // MII Management Data Output
wire        mdoen;     // MII Management Data Output Enable
wire [31:0] ahb_hrdata;  // AHB slave read data
wire  [1:0] ahb_hresp;   // AHB slave response
wire        ahb_hreadyo;  // AHB slave ready
wire        ahb_txhbusreq;   // AHB master bus request
wire  [1:0] ahb_txhtransm;  // AHB master transaction type
wire [31:2] ahb_txhaddrm;   // AHB master transaction address
wire [31:0] ahb_txhaddrm_w;   // AHB master transaction address

wire        ahb_txhwritem;  // AHB master transfer direction
wire [31:0] ahb_txhwdatam;  // AHB master write data bus
wire        ahb_rxhbusreq;   // AHB master bus request
wire  [1:0] ahb_rxhtransm;  // AHB master transaction type
wire [31:2] ahb_rxhaddrm;   // AHB master transaction address
wire [31:0] ahb_rxhaddrm_w;   // AHB master transaction address

wire        ahb_rxhwritem;  // AHB master transfer direction
wire [31:0] ahb_rxhwdatam;  // AHB master write data bus

wire        interrupt; // Host DMA interrupt

wire [9:0] tcg_dut ;    // TCG output.
wire [9:0] rcg_dut  ;    // RCG input.
wire ptp_clk_i ;
wire ptp_1hzclk_i;

wire [9:0] anx_state;
wire sync ;
assign ahb_txhaddrm = ahb_txhaddrm_w [31 :2];
assign ahb_rxhaddrm = ahb_rxhaddrm_w [31 :2];

  CoreTSE_Webserver_CORETSE_AHB_0_CORETSE_AHB
  #(
    .FAMILY(FAMILY),
     .GMII_TBI(GMII_TBI),
     .PACKET_SIZE (PACKET_SIZE),
     .SAL  (SAL  ),
     .WOL  (WOL  ),
     .STATS(STATS),
     .MDIO_PHYID(MDIO_PHYID)
    )
   tsmac_sgmii_top_dut
  (
     //clock-reset	
    .TXCLK(tx_clki ),           // post-Tree TxCLK @125/25/2.5 From PHY/ExtSource
    .RXCLK(rx_clki ),           // post-Tree RxCLK @125/25/2.5 From PHY/ExtSource
    .STBP(1'b0    ),           // Reset Bypass

    //MAC GMII interface signals  - Rx-Path
    .CRS  (crs    ),                 // G/MII Carrier Sense
    .COL  (col    ),                 // G/MII Collision
    .RXDV (rx_dv  ),                 // G/MII Receive Data Valid
    .RXD  (rxd    ),                 // G/MII Receive Data
    .RXER (rx_er  ),                 // G/MII Receive Error
  
    //MAC GMII interface signals  - Tx-Path
    .TXEN (txceno ),                // G/MII Transmit Enable
    .TXD  (txd   ),                 // G/MII Transmit Data
    .TXER (tx_er ),                // G/MII Transmit Error
    .TBI_READY(),
    .TBI_TXVAL(),
    .SIGNAL_DETECT(1'b1),

    //CLOCKS
    .GTXCLK(gtx_clki ),
    .PMARX_CLK0(pma_rx_clk0 /*~clk_62_5_mhz*/),
    .PMARX_CLK1(pma_rx_clk1 /*clk_62_5_mhz*/ ),

    //TBI INTERface signals
    .RCG(rcg_dut),      // RTL rcg 10 bit is connected with tcg 10 bit of VE.
    .TCG(tcg_dut ),      // RTL tcg 10 bit is connected with rcg 10 bit of VE.
// AHB-SYSTEM Bus interface signals
    .HRESETN    (hresetn     ),                 // AHB system reset(active low)
    .HCLK       (hclk        ),                 // AHB system clock
    .HREADY(1'b1   ),                 // AHB ready
    .HWDATA(ahb_hwdata   ),         // AHB write data
    .HADDR ({22'b0, ahb_haddr[9:2],2'b0}   ),         // AHB address
    .HSEL  (ahb_hsel     ),         // AHB slave select
    .HTRANS(ahb_htrans   ),         // AHB transaction type
    .HWRITE(ahb_hwrite   ),         // AHB transaction direction
    .HRDATA(ahb_hrdata   ),         // AHB slave read data
    .HRESP (ahb_hresp    ),         // AHB slave response
    .HREADYOUT(ahb_hreadyo   ),         // AHB slave ready
    .HBURST(),
    .HMASTLOCK(),
    .HSIZE(),

    // TX-DMA AHB-Master interface signals
    .TXHGRANT(ahb_txhgrant),           // AHB bus grant
    .TXHRESP (ahb_txhrespm),           // AHB response
    .TXHRDATA(ahb_txhrdatam),           // AHB read data
    .TXHBUSREQ(ahb_txhbusreq),           // AHB master bus request
    .TXHTRANS(ahb_txhtransm),           // AHB master transaction type
    .TXHADDR (ahb_txhaddrm_w),           // AHB master transaction address
    .TXHWRITE(ahb_txhwritem),           // AHB master transfer direction
    .TXHWDATA(ahb_txhwdatam),           // AHB master write data bus
    .TXHREADY(ahb_hreadyi),             // AHB master ready                   // Change both hready signal.
    .TXHBURST(),
    .TXHLOCK(),
    .TXHSIZE(),
  
    // RX-DMA AHB-MASter interface signals
    .RXHGRANT (ahb_rxhgrant),             // AHB bus grant
    .RXHRESP (ahb_rxhrespm),               // AHB response
    .RXHRDATA(ahb_rxhrdatam ),            // AHB read data
    .RXHBUSREQ(ahb_rxhbusreq ),            // AHB master bus request
    .RXHTRANS(ahb_rxhtransm ),            // AHB master transaction type
    .RXHADDR (ahb_rxhaddrm_w),            // AHB master transaction address
    .RXHWRITE(ahb_rxhwritem ),            // AHB master transfer direction
    .RXHWDATA(ahb_rxhwdatam),             // AHB master write data bus
    .RXHREADY(ahb_hreadyi),               // AHB master ready                // Need to add to different hready signal.
    .RXHLOCK(),
    .RXHBURST(),
    .RXHSIZE(),
    
    // Management interface MDIO signals
    .MDI(mdi ),          // MII Management Data Input
    .MDC(mdc ),          // MII Management Data Clock
    .MDO(mdo ),          // MII Management Data Output
    .MDOEN(mdoen),       // MII Management Data Output Enable
    .TSM_CONTROL(),                            // Host DMA interrupt
    .TSM_INTR(/*TSM_INTR_O*/),                  // Host DMA interrupt
    .ANX_STATE(anx_state),
    .SYNC(sync)

  );


// Test environment instasnce 


CoreTSE_ahb_tb  Coretse_ahb_tb_inst
(
   .tx_clko(tx_clko),     // MII Transmit Clock, Output    ( pre-clock tree )
   .txceno(txceno),       // Transmit Clock Enable, Output ( pre-clock tree )
   .rx_clko(rx_clko),     // MII Receive Clock, Output     ( pre-clock tree )
   .rxceno(rxceno),       // Receive Clock Enable, Output  ( pre-clock tree )
   .tx_en(tx_en),         // G/MII Transmit Enable
   .txd(txd),             // G/MII Transmit Data
   .tx_er(tx_er),         // G/MII Transmit Error
   .mdc(mdc),             // MII Management Data Clock
   .mdo(mdo),             // MII Management Data Output
   .mdoen(mdoen),         // MII Management Data Output Enable
   .ahb_hrdata(ahb_hrdata),   // AHB slave read data
   .ahb_hresp(ahb_hresp),     // AHB slave response
   .ahb_hreadyo(ahb_hreadyo),   // AHB slave ready
   .ahb_txhbusreq(ahb_txhbusreq),     // AHB master bus request
   .ahb_txhtransm(ahb_txhtransm),   // AHB master transaction type
   .ahb_txhaddrm (ahb_txhaddrm),     // AHB master transaction address
   .ahb_txhwritem(ahb_txhwritem),   // AHB master transfer direction
   .ahb_txhwdatam(ahb_txhwdatam),   // AHB master write data bus
   .ahb_rxhbusreq(ahb_rxhbusreq),     // AHB master bus request
   .ahb_rxhtransm(ahb_rxhtransm),   // AHB master transaction type
   .ahb_rxhaddrm (ahb_rxhaddrm),     // AHB master transaction address
   .ahb_rxhwritem(ahb_rxhwritem),   // AHB master transfer direction
   .ahb_rxhwdatam(ahb_rxhwdatam),   // AHB master write data bus

   .interrupt(interrupt), // Host DMA interrupt
    
   .tx_clk(tx_clk),       // MII Transmit Clock ( from external source )
   .tx_clki(tx_clki),     // MII Transmit Clock, Input ( post clock tree )
   .txceni(txceni),       // Transmit Clock Enable, Input ( post clock tree )
   .rx_clk(rx_clk),       // MII Receive Clock  ( from external source )
   .rx_clki(rx_clki),     // MII Receive Clock, Input  ( post clock tree )
   .rxceni(rxceni),       // Receive Clock Enable, Input  ( post clock tree )
   .crs(crs),             // MII Carrier Sense
   .col(col),             // MII Collision
   .mdi(mdi),             // MII Management Data Input
   .rx_dv(rx_dv),         // G/MII Receive Data Valid
   .rxd(rxd),             // G/MII Receive Data
   .rx_er(rx_er),         // G/MII Receive Error
   .rstbp(rstbp),         // Reset Bypass
   .ahb_hwdata(ahb_hwdata),       // AHB write data
   .ahb_haddr(ahb_haddr),         // AHB address
   .ahb_hsel(ahb_hsel),           // AHB slave select
   .ahb_htrans(ahb_htrans),       // AHB transaction type
   .ahb_hwrite(ahb_hwrite),       // AHB transaction direction
   .ahb_txhgrant(ahb_txhgrant),       // AHB bus grant
   .ahb_rxhgrant(ahb_rxhgrant),       // AHB bus grant
   .ahb_txhrespm(ahb_txhrespm),         // AHB response
   .ahb_rxhrespm(ahb_rxhrespm),         // AHB response
   .ahb_txhrdatam(ahb_txhrdatam),       // AHB read data
   .ahb_rxhrdatam(ahb_rxhrdatam),       // AHB read data
   .ahb_hreadyi(ahb_hreadyi),       // AHB ready
   .hresetn(hresetn),     // AHB system reset (active low)
   .hclk(hclk),            // AHB system clock
   // Added new connection for a TBI.
   .tcg_dut(tcg_dut),
   .rcg_dut (rcg_dut),
   .gtx_clki(gtx_clki),
   .pma_rx_clk0(pma_rx_clk0),
   .pma_rx_clk1(pma_rx_clk1),
   .ptp_clk_i( ptp_clk_i),
   .ptp_1hzclk_i(ptp_1hzclk_i),
   .phyid(MDIO_PHYID[4:0]),
   .anx_state(anx_state),
   .sync(sync)
);

endmodule
