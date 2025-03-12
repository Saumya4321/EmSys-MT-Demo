
set_false_path -from [ get_clocks { FCCC_0/GL0 } ] -to [ get_clocks { FCCC_3/GL1 } ]

set_false_path -from [ get_clocks { FCCC_1/GL0 } ] -to [ get_clocks { FCCC_3/GL1 } ]

set_false_path -from [ get_clocks { FCCC_1/GL0 } ] -to [ get_clocks { FCCC_2/GL0 } ]
set_false_path -from [ get_clocks { FCCC_3/GL1 } ] -to [ get_clocks { FCCC_0/GL0 } ]
set_false_path -from [ get_clocks { FCCC_0/GL0 } ] -to [ get_clocks { FCCC_1/GL0 } ]
set_false_path -from [ get_clocks { FCCC_0/GL0 } ] -to [ get_clocks { FCCC_1/GL1 } ]
set_false_path -from [ get_clocks { FCCC_1/GL1 } ] -to [ get_clocks { FCCC_1/GL0 } ]
set_false_path -from [ get_clocks { FCCC_3/GL0 } ] -to [ get_clocks { FCCC_3/GL1 } ]
set_false_path -from [ get_clocks { FCCC_3/GL0 } ] -to [ get_clocks { FCCC_2/GL0 } ]
set_false_path -from [ get_clocks { FCCC_0/GL0 } ] -to [ get_clocks { FCCC_2/GL0 } ]
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBIOI[8]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXVAL[1] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBIOI[8]/CLK } ] -to [ get_pins { SERDES_IF2_0/SERDESIF_INST/EPCS_TXVAL[1] } ]
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[9]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[29] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[9]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[29] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBl0i0/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[29] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBl0i0/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[29] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[8]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[28] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[8]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[28] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBo110/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[28] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBo110/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[28] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[7]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[27] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[7]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[27] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[7]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[27] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[7]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[27] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[6]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[26] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[6]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[26] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[6]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[26] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[6]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[26] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[5]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[25] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[5]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[25] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[5]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[25] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[5]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[25] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[4]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[24] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[4]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[24] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[4]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[24] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[4]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[24] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[3]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[23] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[3]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[23] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[3]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[23] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[3]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[23] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[2]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[22] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[2]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[22] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[2]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[22] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[2]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[22] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[1]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[21] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[1]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[21] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[1]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[21] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[1]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[21] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[0]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[20] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBOoi0/CORETSE_AHBI0i0[0]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[20] }
set_multicycle_path -setup_only 2 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[0]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[20] }
set_multicycle_path -hold 0 -from [ get_pins { CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBio0.CORETSE_AHBOi0/CORETSE_AHBIoi0/CORETSE_AHBiI11/CORETSE_AHBlI1II[0]/CLK } ] -to { SERDES_IF2_0/SERDESIF_INST/EPCS_TXDATA[20] }

set_clock_uncertainty -setup 0.32 -from { SERDES_IF2_0/EPCS_RXCLK[1] } -to { FCCC_1/GL0 }
set_clock_uncertainty -hold 0.32 -from { SERDES_IF2_0/EPCS_RXCLK[1] } -to { FCCC_1/GL0 }
set_clock_uncertainty -setup 0.32 -from { SERDES_IF2_0/EPCS_RXCLK[1] } -to { FCCC_1/GL1 }
set_clock_uncertainty -hold 0.32 -from { SERDES_IF2_0/EPCS_RXCLK[1] } -to { FCCC_1/GL1 }
