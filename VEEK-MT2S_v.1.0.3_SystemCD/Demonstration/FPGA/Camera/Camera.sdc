#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************

# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck 3 [get_ports altera_reserved_tdo]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
#create_clock -period 20.000ns [get_ports CLOCK2_50]
#create_clock -period 20.000ns [get_ports CLOCK3_50]
#create_clock -period 20.000ns [get_ports CLOCK4_50]
#create_clock -period 20.000ns [get_ports CLOCK_50]

create_clock -period "50 MHz" -name CLOCK2_50 [get_ports CLOCK2_50]
create_clock -period "50 MHz" -name CLOCK3_50 [get_ports CLOCK3_50]
create_clock -period "50 MHz" -name CLOCK4_50 [get_ports CLOCK4_50]
create_clock -period "50 MHz" -name CLOCK_50  [get_ports CLOCK_50 ]
create_clock -period "20 MHz" -name MIPI_REFCLK [get_ports MIPI_REFCLK ]




# VGA : 640x480@60Hz
create_clock -period "25.18 MHz" -name VGA_CLK  [get_ports VGA_CLK]
create_clock -period "100 MHz"   -name DRAM_CLK [get_ports DRAM_CLK]


#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty
create_clock -period "25.0 MHz"  -name MIPI_PIXEL_CLK [get_ports MIPI_PIXEL_CLK]


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



