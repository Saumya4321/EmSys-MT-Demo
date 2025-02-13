###==== CLOCKS
# SERDES OUTPUT CLOCKS @ 125MHz
create_clock  -name { EPCS_0_TX_CLK } -period 8.000 -waveform { 0.000 4.000 } [get_nets { SERDES_IF_0_EPCS_0_TX_CLK }] 
create_clock  -name { EPCS_0_RX_CLK } -period 8.000 -waveform { 0.000 4.000 } [get_nets { SERDES_IF_0_EPCS_0_RX_CLK }] 

# 50MHz Host Clock, For example MSS clock 
create_clock  -name { HCLK } -period 20.000 -waveform { 0.000 10.000 } { HCLK  } 


###==== GENERATED CLOCKS
# FCCC_0 clocks
# Input is 125MHz
# GL0 is 62.5MHz, GL1 is 62.5MHz is with 180 out of phase with  GL0

create_generated_clock  -name { PMARX_CLK0 } \
    -divide_by 2  \
    -source [get_nets { SERDES_IF_0_EPCS_0_RX_CLK }]  \
    { FCCC_0/CCC_INST/INST_CCC_IP:GL0  } 

create_generated_clock  -name { PMARX_CLK1 } \
    -divide_by 2  -invert  \
    -source [get_nets { SERDES_IF_0_EPCS_0_RX_CLK }]  \
    { FCCC_0/CCC_INST/INST_CCC_IP:GL1  } 

# FCCC_1 clocks
# Input is 125MHz
# GL0 is 125MHz

create_generated_clock  -name { GTXCLK } \
    -divide_by 1  \
    -source [get_nets { SERDES_IF_0_EPCS_0_TX_CLK }]  \
    { FCCC_1/CCC_INST/INST_CCC_IP:GL0  } 

create_generated_clock  -name { TXCLK } \
    -divide_by 1  \
    -source [get_nets { SERDES_IF_0_EPCS_0_TX_CLK }]  \
    { FCCC_1/CCC_INST/INST_CCC_IP:GL1  } 

create_generated_clock  -name { RXCLK } \
    -divide_by 1  \
    -source [get_nets { SERDES_IF_0_EPCS_0_TX_CLK }]  \
    { FCCC_1/CCC_INST/INST_CCC_IP:GL2  } 

# MDC clock is generated clock from CoreTSE_AHB, internally the source for the MDC clock is HCLK

create_generated_clock  -name { MDC } \
    -divide_by 14  \
\
       -source { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBiOooI/CORETSE_AHBooOo/CORETSE_AHBi01:CLK  }  \
    { MDC  } 

   

# False paths for the timing analysis, below clock domain crossing paths are handled with FIFOs and synchronizers to take care of clock crossings

set_false_path -from { PMARX_CLK0  }  -to { GTXCLK  } 

set_false_path -from { EPCS_0_RX_CLK  }  -to { PMARX_CLK0  } 

set_false_path -from { EPCS_0_RX_CLK  }  -to { PMARX_CLK1  } 

set_false_path -from { HCLK  }  -to { RXCLK  } 

set_false_path -from { RXCLK  }  -to { HCLK  } 

set_false_path -from { PMARX_CLK0  }  -to { RXCLK  } 

set_false_path -from { HCLK  }  -to { PMARX_CLK0  } 

set_false_path -from { TXCLK  }  -to { GTXCLK  } 

set_false_path -from { HCLK  }  -to { GTXCLK  } 

set_false_path -from { PMARX_CLK0  }  -to { TXCLK  } 

set_false_path -from { HCLK  }  -to { TXCLK  } 

set_false_path -from { GTXCLK  }  -to { EPCS_0_RX_CLK  } 

set_false_path -from { GTXCLK  }  -to { EPCS_0_TX_CLK  } 

set_false_path -from { TXCLK  }  -to { HCLK  } 

set_false_path -from { GTXCLK  }  -to { PMARX_CLK1  } 

set_false_path -from { GTXCLK  }  -to { PMARX_CLK0  } 

set_false_path -from { PMARX_CLK1  }  -to { PMARX_CLK0  } 


###==== Max delay constraints  
# In case of Register to Register   timing violation within TXCLK, RXCLK, GTXCLK, HCLK, MDC,PMARX_CLK0 and PMARX_CLK0 clocks domain. 
# Check the violation reported nets in the smart time and set set_max_delay constraint slightly lesser than the required delay value reported the smart time tool. 
# below nets were reported for an example design in TXCLK and RXCLK clock domain  

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBil1I[4]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[2]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBil1I[4]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[2]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBil1I[4]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[2]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[0]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBil1I[4]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[1]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBil1I[4]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[2]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[4]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBil1I[4]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[0]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[11]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBIloI[3].CORETSE_AHBl0i[27]:EN  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[1]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[4]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[3]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[11]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[2]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[11]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[10]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBIloI[3].CORETSE_AHBl0i[27]:EN  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBi01I[2]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBl1II/CORETSE_AHBOI1I[11]:D  } 

set_max_delay 14.000\
    -from { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBO1II/CORETSE_AHBOIiI[5]:CLK  } \
    -to { \
CORETSE_AHB_0/CoreTSE_top_inst/CORETSE_AHBilI/CORETSE_AHBoOooI/CORETSE_AHBO1II/CORETSE_AHBoIiI:D  } 


