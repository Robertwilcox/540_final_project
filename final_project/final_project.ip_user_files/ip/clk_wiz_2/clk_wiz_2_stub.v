// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Nov 13 16:14:09 2023
// Host        : DESKTOP-T2LGR09 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Fall_2023/ECE_540/proj_2/part_1/project_1/project_1.gen/sources_1/ip/clk_wiz_2/clk_wiz_2_stub.v
// Design      : clk_wiz_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_2(vga_clk, vga_clk_x5, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="vga_clk,vga_clk_x5,reset,locked,clk_in1" */;
  output vga_clk;
  output vga_clk_x5;
  input reset;
  output locked;
  input clk_in1;
endmodule
