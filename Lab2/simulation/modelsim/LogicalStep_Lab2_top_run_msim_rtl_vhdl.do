transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/z234gao/Lab2 (2)/Lab2/Lab2/SevenSegment.vhd}
vcom -93 -work work {C:/Users/z234gao/Lab2 (2)/Lab2/Lab2/segment7_mux.vhd}
vcom -93 -work work {C:/Users/z234gao/Lab2 (2)/Lab2/Lab2/LogicalStep_Lab2_top.vhd}
vcom -93 -work work {C:/Users/z234gao/Lab2 (2)/Lab2/Lab2/hex_mux.vhd}
vcom -93 -work work {C:/Users/z234gao/Lab2 (2)/Lab2/Lab2/PB_Inverters.vhd}

