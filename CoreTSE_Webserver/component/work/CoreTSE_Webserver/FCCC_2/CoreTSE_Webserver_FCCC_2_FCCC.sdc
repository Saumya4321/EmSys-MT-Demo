set_component CoreTSE_Webserver_FCCC_2_FCCC
# Microsemi Corp.
# Date: 2016-Nov-17 15:25:32
#

create_clock -period 8 [ get_pins { CCC_INST/CLK0 } ]
create_generated_clock -multiply_by 4 -divide_by 4 -source [ get_pins { CCC_INST/CLK0 } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
