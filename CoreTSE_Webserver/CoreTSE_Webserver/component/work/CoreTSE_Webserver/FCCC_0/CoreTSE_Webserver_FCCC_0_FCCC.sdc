set_component CoreTSE_Webserver_FCCC_0_FCCC
# Microsemi Corp.
# Date: 2016-Nov-17 15:25:28
#

create_clock -period 20 [ get_pins { CCC_INST/CLK1_PAD } ]
create_generated_clock -multiply_by 2 -divide_by 2 -source [ get_pins { CCC_INST/CLK1_PAD } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
