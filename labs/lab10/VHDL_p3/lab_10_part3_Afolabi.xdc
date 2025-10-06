# Clock signal
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}]

# Switches
set_property PACKAGE_PIN V17 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]

# Reset
set_property PACKAGE_PIN R2 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {comp_sync}]
set_property IOSTANDARD LVCMOS33 [get_ports {comp_sync}]
set_property PACKAGE_PIN E19 [get_ports {vga_pixel_tick}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_pixel_tick}]
set_property PACKAGE_PIN U19 [get_ports {blank}]
set_property IOSTANDARD LVCMOS33 [get_ports {blank}]

# Buttons
set_property PACKAGE_PIN W19 [get_ports {btn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[1]}]
set_property PACKAGE_PIN T17 [get_ports {btn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[0]}]

# RGB Pins
set_property PACKAGE_PIN N19 [get_ports {rgb_top[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_top[2]}]
set_property PACKAGE_PIN J18 [get_ports {rgb_top[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_top[1]}]
set_property PACKAGE_PIN D17 [get_ports {rgb_top[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_top[0]}]

# VGA Sync
set_property PACKAGE_PIN P19 [get_ports {hsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {hsync}]
set_property PACKAGE_PIN R19 [get_ports {vsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {vsync}]

# USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports {RsRx}]
set_property IOSTANDARD LVCMOS33 [get_ports {RsRx}]
set_property PACKAGE_PIN A18 [get_ports {RsTx}]
set_property IOSTANDARD LVCMOS33 [get_ports {RsTx}]
