set_component CoreTSE_Webserver_FCCC_3_FCCC
# Microsemi Corp.
# Date: 2016-Nov-17 15:25:34
#

create_clock -period 8 [ get_pins { CCC_INST/CLK0 } ]
create_clock -period 8 [ get_pins { CCC_INST/CLK1 } ]
create_generated_clock -multiply_by 4 -divide_by 4 -source [ get_pins { CCC_INST/CLK0 } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
create_generated_clock -divide_by 1 -source [ get_pins { CCC_INST/CLK1 } ] [ get_pins { CCC_INST/GL1 } ]
