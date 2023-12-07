# mclk is from the 100 MHz oscillator on Boolean board
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];
create_clock -add -name tck_dmi -period 100.00 [get_pins tap/tap_dmi/TCK];
create_clock -add -name tck_dtmcs -period 100.00 [get_pins tap/tap_dtmcs/TCK];
create_clock -add -name tck_idcode -period 100.00 [get_pins tap/tap_idcode/DRCK];

# Set Bank 0 voltage
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# UART
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports i_uart_rx]
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports o_uart_tx]

# Servo
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {SERVO_PWM}]

# PWM for DC_MOTOR
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {DC_MOTOR}]

# HDMI: CLK signals
set_property -dict {PACKAGE_PIN T14 IOSTANDARD TMDS_33} [get_ports {o_hdmi_clk_n}]
set_property -dict {PACKAGE_PIN R14 IOSTANDARD TMDS_33} [get_ports {o_hdmi_clk_p}]

# HDMI: DATA signals
set_property -dict {PACKAGE_PIN T15 IOSTANDARD TMDS_33} [get_ports {o_hdmi_d_n[0]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD TMDS_33} [get_ports {o_hdmi_d_n[1]}]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD TMDS_33} [get_ports {o_hdmi_d_n[2]}]

set_property -dict {PACKAGE_PIN R15 IOSTANDARD TMDS_33} [get_ports {o_hdmi_d_p[0]}]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD TMDS_33} [get_ports {o_hdmi_d_p[1]}]
set_property -dict {PACKAGE_PIN N15 IOSTANDARD TMDS_33} [get_ports {o_hdmi_d_p[2]}]

# PMOD D Signals
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {i_pmodD[0]}]    
set_property -dict {PACKAGE_PIN N5 IOSTANDARD LVCMOS33} [get_ports {i_pmodD[1]}]
set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports {i_pmodD[2]}]
set_property -dict {PACKAGE_PIN R4 IOSTANDARD LVCMOS33} [get_ports {i_pmodD[3]}]

set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS33} [get_ports {o_pmodD[0]}]
set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVCMOS33} [get_ports {o_pmodD[1]}]
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {o_pmodD[2]}]
set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS33} [get_ports {o_pmodD[3]}]

# On-board Slide Switches
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {i_sw[0]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {i_sw[1]}]
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {i_sw[2]}]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {i_sw[3]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {i_sw[4]}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {i_sw[5]}]
set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports {i_sw[6]}]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports {i_sw[7]}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {i_sw[8]}]
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports {i_sw[9]}]
set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS33} [get_ports {i_sw[10]}]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports {i_sw[11]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {i_sw[12]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {i_sw[13]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {i_sw[14]}]
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {i_sw[15]}]

# On-board LEDs
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {o_led[0]}]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {o_led[1]}]
set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS33} [get_ports {o_led[2]}]
set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVCMOS33} [get_ports {o_led[3]}]
set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports {o_led[4]}]
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports {o_led[5]}]
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports {o_led[6]}]
set_property -dict {PACKAGE_PIN E5 IOSTANDARD LVCMOS33} [get_ports {o_led[7]}]
set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS33} [get_ports {o_led[8]}]
set_property -dict {PACKAGE_PIN C3 IOSTANDARD LVCMOS33} [get_ports {o_led[9]}]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {o_led[10]}]
set_property -dict {PACKAGE_PIN A2 IOSTANDARD LVCMOS33} [get_ports {o_led[11]}]
set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS33} [get_ports {o_led[12]}]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {o_led[13]}]
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {o_led[14]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {o_led[15]}]

# On-board 7-Segment display 0
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {AN[4]}]
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {AN[5]}]
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {AN[6]}]
set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports {AN[7]}]
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {CA}]
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {CB}]
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {CC}]
set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {CD}]
set_property -dict {PACKAGE_PIN A7 IOSTANDARD LVCMOS33} [get_ports {CE}]
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS33} [get_ports {CF}]
set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS33} [get_ports {CG}]

# On-board 7-Segment display 1
set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33} [get_ports {AN[0]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {AN[1]}]
set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports {AN[2]}]
set_property -dict {PACKAGE_PIN E4 IOSTANDARD LVCMOS33} [get_ports {AN[3]}]
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports {CA_1}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {CB_1}]
set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports {CC_1}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {CD_1}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {CE_1}]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {CF_1}]
set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS33} [get_ports {CG_1}]

# On-board Push Buttons
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {i_bttn[0]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {i_bttn[1]}]
set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports {i_bttn[2]}]
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports {i_bttn[3]}]

# On-board RGB LEDs
set_property -dict {PACKAGE_PIN V6 IOSTANDARD LVCMOS33} [get_ports {o_rgb0[0]}];   # RBG0_R
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {o_rgb0[1]}];   # RBG0_G
set_property -dict {PACKAGE_PIN U6 IOSTANDARD LVCMOS33} [get_ports {o_rgb0[2]}];   # RBG0_B
set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports {o_rgb1[0]}];   # RBG1_R
set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS33} [get_ports {o_rgb1[1]}];   # RBG1_G
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {o_rgb1[2]}];   # RBG1_B

#======================================================================================
# Added by: Mohamed Gnedi
#=========== SECTION ADDED for Pmod Joystick part Final Project =======================
##Pmod Headers
##Pmod Header JA (Nexys)
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { SS }]; #IO_L20N_T3_A19_15 Sch=ja[1]       (Pin1) Top Rightmost pin
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { MISO }]; #IO_L21P_T3_DQS_15 Sch=ja[3]     (Pin3)
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { SCLK }]; #IO_L18N_T2_A23_15 Sch=ja[4]     (Pin4)
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { JA[7] }]; #IO_L16N_T2_A27_15 Sch=ja[7]
#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { JA[8] }]; #IO_L16P_T2_A28_15 Sch=ja[8]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { JA[9] }]; #IO_L22N_T3_A16_15 Sch=ja[9]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { JA[10] }]; #IO_L22P_T3_A17_15 Sch=ja[10]

##Pmod Headers
##Pmod Header A (Boolean Board)
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { SCLK }]; #IO_L20N_T3_A19_15 Sch=ja[1]
set_property -dict { PACKAGE_PIN B14   IOSTANDARD LVCMOS33 } [get_ports { MISO }]; #IO_L21N_T3_DQS_A18_15 Sch=ja[2]
#set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS33 } [get_ports { JA[3] }]; #IO_L21P_T3_DQS_15 Sch=ja[3]
set_property -dict { PACKAGE_PIN B13   IOSTANDARD LVCMOS33 } [get_ports { SS }]; #IO_L18N_T2_A23_15 Sch=ja[4]

#set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS33 } [get_ports { JA[7] }]; #IO_L16N_T2_A27_15 Sch=ja[7]
#set_property -dict { PACKAGE_PIN C13   IOSTANDARD LVCMOS33 } [get_ports { JA[8] }]; #IO_L16P_T2_A28_15 Sch=ja[8]
#set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { JA[9] }]; #IO_L22N_T3_A16_15 Sch=ja[9]
#set_property -dict { PACKAGE_PIN E12   IOSTANDARD LVCMOS33 } [get_ports { JA[10] }]; #IO_L22P_T3_A17_15 Sch=ja[10]
