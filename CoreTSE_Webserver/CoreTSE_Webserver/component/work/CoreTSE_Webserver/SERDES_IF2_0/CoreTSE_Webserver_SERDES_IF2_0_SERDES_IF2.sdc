set_component CoreTSE_Webserver_SERDES_IF2_0_SERDES_IF2
# Microsemi Corp.
# Date: 2016-Nov-17 15:25:42
#

create_clock -period 8 [ get_pins { EPCS_3_RX_CLK } ]
create_clock -period 8 [ get_pins { EPCS_3_TX_CLK } ]
