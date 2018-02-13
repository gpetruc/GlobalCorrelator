# FROM UG1224 VCU118 board user guide, chapter 3
# Using 300 MHz system clock from the board
set_property IOSTANDARD DIFF_SSTL12 [get_ports sysclk_in_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports sysclk_in_n]
set_property PACKAGE_PIN G31 [get_ports sysclk_in_p]
set_property PACKAGE_PIN F31 [get_ports sysclk_in_n]
# Also using 125 MHz system clock from the board
set_property IOSTANDARD LVDS [get_ports sysclk125_in_p]
set_property IOSTANDARD LVDS [get_ports sysclk125_in_n]
set_property PACKAGE_PIN AY24 [get_ports sysclk125_in_p]
set_property PACKAGE_PIN AY23 [get_ports sysclk125_in_n]

# Table 3-29 of UG1224 VCU118 board user guide
# Also /Vivado/2016.4/data/boards/board_files/vcu118/1.0/part0_pins.xml
set_property IOSTANDARD LVCMOS12 [get_ports {leds[*]}]
set_property PACKAGE_PIN AY30 [get_ports {leds[0]}]
set_property PACKAGE_PIN BB32 [get_ports {leds[1]}]
set_property PACKAGE_PIN BF32 [get_ports {leds[2]}]
# push-button SW 10 pin GPIO_SW_N
set_property IOSTANDARD LVCMOS18 [get_ports rst_in]
set_property PACKAGE_PIN BB24 [get_ports rst_in]
