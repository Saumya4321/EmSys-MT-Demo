# Microsemi Corp.
# Date: 2016-Nov-17 15:35:45
# This file was generated based on the following SDC source files:
#   D:/CASES/coretse/CoreTSE_Webserver/constraint/CoreTSE_Webserver_derived_constraints.sdc
#   D:/CASES/coretse/CoreTSE_Webserver/constraint/user.sdc
#

create_clock -name {CoreTSE_Webserver_MSS_0/CLK_CONFIG_APB} -period 80 [ get_pins { CoreTSE_Webserver_MSS_0/MSS_ADLIB_INST/CLK_CONFIG_APB } ]
create_clock -name {CLK1_PAD} -period 20 [ get_ports { CLK1_PAD } ]
create_clock -name {SERDES_IF2_0/SERDESIF_INST/EPCS_RXCLK[1]} -period 8 [ get_pins { SERDES_IF2_0/SERDESIF_INST/EPCS_RXCLK[1] } ]
create_clock -name {SERDES_IF2_0/SERDESIF_INST/EPCS_TXCLK[1]} -period 8 [ get_pins { SERDES_IF2_0/SERDESIF_INST/EPCS_TXCLK[1] } ]
create_clock -name {OSC_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { OSC_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_generated_clock -name {FCCC_0/GL0} -multiply_by 2 -divide_by 2 -source [ get_pins { FCCC_0/CCC_INST/CLK1_PAD } ] -phase 0 [ get_pins { FCCC_0/CCC_INST/GL0 } ]
create_generated_clock -name {FCCC_1/GL0} -multiply_by 2 -divide_by 4 -source [ get_pins { FCCC_1/CCC_INST/CLK0 } ] -phase 0 [ get_pins { FCCC_1/CCC_INST/GL0 } ]
create_generated_clock -name {FCCC_1/GL1} -invert -multiply_by 2 -divide_by 4 -source [ get_pins { FCCC_1/CCC_INST/CLK0 } ] -phase 0 [ get_pins { FCCC_1/CCC_INST/GL1 } ]
create_generated_clock -name {FCCC_2/GL0} -multiply_by 4 -divide_by 4 -source [ get_pins { FCCC_2/CCC_INST/CLK0 } ] -phase 0 [ get_pins { FCCC_2/CCC_INST/GL0 } ]
create_generated_clock -name {FCCC_3/GL0} -multiply_by 4 -divide_by 4 -source [ get_pins { FCCC_3/CCC_INST/CLK0 } ] -phase 0 [ get_pins { FCCC_3/CCC_INST/GL0 } ]
create_generated_clock -name {FCCC_3/GL1} -divide_by 1 -source [ get_pins { FCCC_3/CCC_INST/CLK1 } ] [ get_pins { FCCC_3/CCC_INST/GL1 } ]
set_false_path -through [ get_nets { CoreConfigP_0/INIT_DONE CoreConfigP_0/SDIF_RELEASED } ]
set_false_path -through [ get_nets { CoreResetP_0/ddr_settled CoreResetP_0/count_ddr_enable CoreResetP_0/release_sdif*_core CoreResetP_0/count_sdif*_enable } ]
set_false_path -from [ get_cells { CoreResetP_0/MSS_HPMS_READY_int } ] -to [ get_cells { CoreResetP_0/sm0_areset_n_rcosc CoreResetP_0/sm0_areset_n_rcosc_q1 } ]
set_false_path -from [ get_cells { CoreResetP_0/MSS_HPMS_READY_int CoreResetP_0/SDIF*_PERST_N_re } ] -to [ get_cells { CoreResetP_0/sdif*_areset_n_rcosc* } ]
set_false_path -through [ get_nets { CoreResetP_0/CONFIG1_DONE CoreResetP_0/CONFIG2_DONE CoreResetP_0/SDIF*_PERST_N CoreResetP_0/SDIF*_PSEL CoreResetP_0/SDIF*_PWRITE CoreResetP_0/SDIF*_PRDATA[*] CoreResetP_0/SOFT_EXT_RESET_OUT CoreResetP_0/SOFT_RESET_F2M CoreResetP_0/SOFT_M3_RESET CoreResetP_0/SOFT_MDDR_DDR_AXI_S_CORE_RESET CoreResetP_0/SOFT_FDDR_CORE_RESET CoreResetP_0/SOFT_SDIF*_PHY_RESET CoreResetP_0/SOFT_SDIF*_CORE_RESET CoreResetP_0/SOFT_SDIF0_0_CORE_RESET CoreResetP_0/SOFT_SDIF0_1_CORE_RESET } ]
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
set_max_delay 0 -through [ get_nets { CoreConfigP_0/FIC_2_APB_M_PSEL CoreConfigP_0/FIC_2_APB_M_PENABLE } ] -to [ get_cells { CoreConfigP_0/FIC_2_APB_M_PREADY* CoreConfigP_0/state[0] } ]
set_min_delay -24 -through [ get_nets { CoreConfigP_0/FIC_2_APB_M_PWRITE CoreConfigP_0/FIC_2_APB_M_PADDR[*] CoreConfigP_0/FIC_2_APB_M_PWDATA[*] CoreConfigP_0/FIC_2_APB_M_PSEL CoreConfigP_0/FIC_2_APB_M_PENABLE } ]
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
