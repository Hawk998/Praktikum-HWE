onerror {resume}
radix define fixed#22#decimal#signed -fixed -fraction 22 -signed -base signed -precision 6
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider testbench
add wave -noupdate /nco_voyager_top_tb/delta_index_i
add wave -noupdate /nco_voyager_top_tb/valid_i
add wave -noupdate /nco_voyager_top_tb/real_i
add wave -noupdate /nco_voyager_top_tb/imag_i
add wave -noupdate /nco_voyager_top_tb/valid_o
add wave -noupdate /nco_voyager_top_tb/real_o
add wave -noupdate /nco_voyager_top_tb/imag_o
add wave -noupdate -divider NCO_top
add wave -noupdate /nco_voyager_top_tb/DUT/clk
add wave -noupdate /nco_voyager_top_tb/DUT/rst
add wave -noupdate -radix fixed#22#decimal#signed /nco_voyager_top_tb/DUT/delta_index_i
add wave -noupdate /nco_voyager_top_tb/DUT/valid_i
add wave -noupdate /nco_voyager_top_tb/DUT/real_o
add wave -noupdate /nco_voyager_top_tb/DUT/imag_o
add wave -noupdate /nco_voyager_top_tb/DUT/real_o_temp
add wave -noupdate /nco_voyager_top_tb/DUT/imag_o_temp
add wave -noupdate /nco_voyager_top_tb/DUT/lut_index
add wave -noupdate /nco_voyager_top_tb/DUT/lut_sine
add wave -noupdate /nco_voyager_top_tb/DUT/cosine
add wave -noupdate /nco_voyager_top_tb/DUT/sine
add wave -noupdate /nco_voyager_top_tb/DUT/quadrant_r
add wave -noupdate /nco_voyager_top_tb/DUT/quadrant_r1
add wave -noupdate /nco_voyager_top_tb/DUT/real_i_r1
add wave -noupdate /nco_voyager_top_tb/DUT/imag_i_r1
add wave -noupdate -divider index_incr
add wave -noupdate /nco_voyager_top_tb/DUT/INDXINCR/delta_index_i
add wave -noupdate /nco_voyager_top_tb/DUT/INDXINCR/valid_i
add wave -noupdate /nco_voyager_top_tb/DUT/INDXINCR/lut_index_o
add wave -noupdate /nco_voyager_top_tb/DUT/INDXINCR/accu_reg_r
add wave -noupdate /nco_voyager_top_tb/DUT/INDXINCR/accu_reg_temp
add wave -noupdate /nco_voyager_top_tb/DUT/INDXINCR/delta_index_r
add wave -noupdate /nco_voyager_top_tb/DUT/INDXINCR/valid_r
add wave -noupdate -divider cos_RAM
add wave -noupdate /nco_voyager_top_tb/DUT/COS/MIF
add wave -noupdate /nco_voyager_top_tb/DUT/COS/address
add wave -noupdate /nco_voyager_top_tb/DUT/COS/data
add wave -noupdate /nco_voyager_top_tb/DUT/COS/wren
add wave -noupdate /nco_voyager_top_tb/DUT/COS/q
add wave -noupdate -divider cos_RAM
add wave -noupdate /nco_voyager_top_tb/DUT/SIN/MIF
add wave -noupdate /nco_voyager_top_tb/DUT/SIN/address
add wave -noupdate /nco_voyager_top_tb/DUT/SIN/data
add wave -noupdate /nco_voyager_top_tb/DUT/SIN/wren
add wave -noupdate /nco_voyager_top_tb/DUT/SIN/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1239225 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 139
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {9450 ns}
