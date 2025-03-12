set_component CoreTSE_Webserver_FCCC_1_FCCC
# Microsemi Corp.
# Date: 2016-Nov-17 15:25:30
#

create_clock -period 8 [ get_pins { CCC_INST/CLK0 } ]
create_generated_clock -multiply_by 2 -divide_by 4 -source [ get_pins { CCC_INST/CLK0 } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
create_generated_clock -invert -multiply_by 2 -divide_by 4 -source [ get_pins { CCC_INST/CLK0 } ] -phase 0 [ get_pins { CCC_INST/GL1 } ]
