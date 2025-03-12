# Clocks 
create_clock -period 8.000 -waveform {0.000 4.000} -name {TXCLK} [get_ports {TXCLK}] 
create_clock -period 8.000 -waveform {0.000 4.000} -name {RXCLK} [get_ports {RXCLK}] 
create_clock -period 8.000 -waveform {0.000 4.000} -name {GTXCLK} [get_ports {GTXCLK}] 
create_clock -period 16.000 -waveform {0.000 8.000} -name {PMARX_CLK0} [get_ports {PMARX_CLK0}] 
create_clock -period 16.000 -waveform {0.000 8.000} -name {PMARX_CLK1} [get_ports {PMARX_CLK1}] 
create_clock -period 16.000 -waveform {0.000 8.000} -name {HCLK} [get_ports {HCLK}] 

