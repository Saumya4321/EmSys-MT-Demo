set_component CoreTSE_Webserver_MSS
# Microsemi Corp.
# Date: 2016-Nov-17 15:24:48
#

create_clock -period 80 [ get_pins { MSS_ADLIB_INST/CLK_CONFIG_APB } ]
