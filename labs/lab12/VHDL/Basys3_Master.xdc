##=============================================================
## Basys-3 Pong Lab12 Constraint File
##=============================================================

## 1) 100 MHz Clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name sys_clk_pin -period 10.00 [get_ports clk]

## 2) Active-High Reset (wired to SW0)
set_property PACKAGE_PIN V17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## 3) Push-buttons → btn(2 downto 0)
##     btn(0) = Up,  btn(1) = Down,  btn(2) = Fire (Center)
set_property PACKAGE_PIN T18 [get_ports {btn[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {btn[0]}]

set_property PACKAGE_PIN U17 [get_ports {btn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[1]}]

set_property PACKAGE_PIN U18 [get_ports {btn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[2]}]

## 4) VGA Color Outputs → rgb(2:0)
##     rgb(2)=Red, rgb(1)=Green, rgb(0)=Blue
set_property PACKAGE_PIN G19 [get_ports {rgb[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[2]}]

set_property PACKAGE_PIN J17 [get_ports {rgb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[1]}]

set_property PACKAGE_PIN N18 [get_ports {rgb[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[0]}]

## 5) VGA Sync Signals
set_property PACKAGE_PIN P19 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]

set_property PACKAGE_PIN R19 [get_ports vsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]

## 6) Composite Sync (optional on VGA D-sub)
set_property PACKAGE_PIN J1  [get_ports comp_sync]
set_property IOSTANDARD LVCMOS33 [get_ports comp_sync]
