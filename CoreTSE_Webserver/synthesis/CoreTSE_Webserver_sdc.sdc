# Written by Synplify Pro version mapact, Build 1659R. Synopsys Run ID: sid1479376609 
# Top Level Design Parameters 

# Clocks 
create_clock -period 20.000 -waveform {0.000 10.000} -name {CLK1_PAD} [get_ports {CLK1_PAD}] 
create_clock -period 80.000 -waveform {0.000 40.000} -name {CoreTSE_Webserver_MSS_0/CLK_CONFIG_APB} [get_pins {CoreTSE_Webserver_MSS_0/MSS_ADLIB_INST:CLK_CONFIG_APB}] 
create_clock -period 20.000 -waveform {0.000 10.000} -name {OSC_0/I_RCOSC_25_50MHZ/CLKOUT} [get_pins {OSC_0/I_RCOSC_25_50MHZ:CLKOUT}] 
create_clock -period 8.000 -waveform {0.000 4.000} -name {SERDES_IF2_0/SERDESIF_INST/EPCS_RXCLK[1]} [get_pins {SERDES_IF2_0/SERDESIF_INST:EPCS_RXCLK[1]}] 
create_clock -period 8.000 -waveform {0.000 4.000} -name {SERDES_IF2_0/SERDESIF_INST/EPCS_TXCLK[1]} [get_pins {SERDES_IF2_0/SERDESIF_INST:EPCS_TXCLK[1]}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {pemgt|CORETSE_AHBi01_inferred_clock} [get_pins {CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBiOooI/CORETSE_AHBooOo/CORETSE_AHBi01:Q}] 

# Virtual Clocks 

# Generated Clocks 
create_generated_clock -name {FCCC_0/GL0} -multiply_by {2} -divide_by {2} -source [get_pins {FCCC_0/CLK1_PAD_INST:Y}]  [get_pins {FCCC_0/CCC_INST:GL0}] 
create_generated_clock -name {FCCC_1/GL0} -multiply_by {2} -divide_by {4} -source [get_pins {SERDES_IF2_0/SERDESIF_INST:EPCS_RXCLK[1]}]  [get_pins {FCCC_1/CCC_INST:GL0}] 
create_generated_clock -name {FCCC_1/GL1} -invert -multiply_by {2} -divide_by {4} -source [get_pins {SERDES_IF2_0/SERDESIF_INST:EPCS_RXCLK[1]}]  [get_pins {FCCC_1/CCC_INST:GL1}] 
create_generated_clock -name {FCCC_2/GL0} -multiply_by {4} -divide_by {4} -source [get_pins {SERDES_IF2_0/SERDESIF_INST:EPCS_TXCLK[1]}]  [get_pins {FCCC_2/CCC_INST:GL0}] 
create_generated_clock -name {FCCC_3/GL0} -multiply_by {4} -divide_by {4} -source [get_pins {SERDES_IF2_0/SERDESIF_INST:EPCS_TXCLK[1]}]  [get_pins {FCCC_3/CCC_INST:GL0}] 
create_generated_clock -name {FCCC_3/GL1} -divide_by {1} -source [get_pins {FCCC_3/GL0_INST:Y}]  [get_pins {FCCC_3/CCC_INST:GL1}] 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 
set_false_path -through [get_pins {CoreResetP_0/INIT_DONE_int:Q CoreResetP_0/SDIF_RELEASED_int:Q}] 
set_false_path -through [get_pins {CoreResetP_0/VCC:Y CoreResetP_0/VCC:Y CoreResetP_0/VCC:Y CoreResetP_0/VCC:Y CoreConfigP_0/control_reg_1[0]:Q CoreConfigP_0/control_reg_1[1]:Q}] 
set_false_path -through [get_pins {CoreResetP_0/release_sdif2_core:Q CoreResetP_0/release_sdif3_core:Q CoreResetP_0/count_sdif0_enable:Q CoreResetP_0/ddr_settled:Q CoreResetP_0/release_sdif0_core:Q CoreResetP_0/release_sdif1_core:Q}] 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set_clock_groups -asynchronous -group [get_clocks {pemgt|CORETSE_AHBi01_inferred_clock}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 
# set_false_path -from {[get_cells { CoreResetP_0.MSS_HPMS_READY_int }]} -to {[get_cells { CoreResetP_0.sm0_areset_n_rcosc CoreResetP_0.sm0_areset_n_rcosc_q1 }]}
# set_false_path -from {[get_cells { CoreResetP_0.MSS_HPMS_READY_int CoreResetP_0.SDIF*_PERST_N_re }]} -to {[get_cells { CoreResetP_0.sdif*_areset_n_rcosc* }]}
# set_max_delay {0} -through {[get_nets { CoreConfigP_0.FIC_2_APB_M_PSEL CoreConfigP_0.FIC_2_APB_M_PENABLE }]} -to {[get_cells { CoreConfigP_0.FIC_2_APB_M_PREADY* CoreConfigP_0.state[0] }]}
# set_min_delay {-24} -through {[get_nets { CoreConfigP_0.FIC_2_APB_M_PWRITE CoreConfigP_0.FIC_2_APB_M_PADDR[*] CoreConfigP_0.FIC_2_APB_M_PWDATA[*] CoreConfigP_0.FIC_2_APB_M_PSEL CoreConfigP_0.FIC_2_APB_M_PENABLE }]}

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

