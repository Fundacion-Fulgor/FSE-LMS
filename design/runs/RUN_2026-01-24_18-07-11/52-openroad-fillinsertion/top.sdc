###############################################################################
# Created by write_sdc
###############################################################################
current_design top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clkA -period 20.0000 [get_ports {clkA}]
set_clock_transition 0.1000 [get_clocks {clkA}]
set_clock_uncertainty 0.2000 clkA
set_propagated_clock [get_clocks {clkA}]
create_clock -name spi_sclk -period 100.0000 [get_ports {spi_sclk}]
set_clock_transition 0.2000 [get_clocks {spi_sclk}]
set_clock_uncertainty 0.5000 spi_sclk
set_propagated_clock [get_clocks {spi_sclk}]
set_clock_groups -name group1 -asynchronous \
 -group [get_clocks {clkA}]\
 -group [get_clocks {spi_sclk}]
set_input_delay 10.0000 -clock [get_clocks {spi_sclk}] -add_delay [get_ports {spi_mosi}]
set_input_delay 10.0000 -clock [get_clocks {spi_sclk}] -add_delay [get_ports {spi_ss_n}]
set_input_delay 5.0000 -clock [get_clocks {clkA}] -add_delay [get_ports {x_serial}]
set_false_path\
    -from [get_ports {reset}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
