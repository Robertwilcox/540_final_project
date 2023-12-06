/*
 * Authors: Ibrahim Binmahfood, Mohamed Gnedi
 * ECE540, Kravitz
 * Project 2, Part 1: VGA Controller - wrapper module
 * 11/17/2023
 *
 * Platform: RVfpga on Boolean Board
 * Description: Wraps the system verilog rtl module 'vga_ctrlr' into a verilog
 * module. Due to System Verilog not directly supported by Vivado for rtl modules
 * System Verilog.
 *
 */

module vga_ctrlr_wrapper
    (input wire i_clk,
     input wire i_rst,
     // Wishbone Interface
     input wire [5:0] i_wb_adr,         // only require 6 bits for addresses in mind
     input wire [31:0] i_wb_dat,        
     input wire [3:0] i_wb_sel,         // at most only need 4 select lines
     input wire i_wb_we,
     input wire i_wb_cyc,
     input wire i_wb_stb,
     output wire [31:0] o_wb_dat,       // 32 bit register peripheral
     output wire o_wb_ack,
     // VGA CLK signals
     input wire         i_vga_clk,       // pixel clock @25.20 MHz
     // VGA Vertical and Horizontal signals
     output wire        o_vga_v_sync,
     output wire        o_vga_h_sync,
     // VGA 4 bit output colors
     output wire [3:0]  o_vga_red,
     output wire [3:0]  o_vga_green,
     output wire [3:0]  o_vga_blue,
     output wire        o_vga_vid_en);  // enable video


    
    vga_ctrlr vgacon
       (.i_clk         (i_clk),
        .i_rst         (i_rst),
        .i_wb_adr      (i_wb_adr),
        .i_wb_dat      (i_wb_dat),
        .i_wb_sel      (i_wb_sel),
        .i_wb_we       (i_wb_we),
        .i_wb_cyc      (i_wb_cyc),
        .i_wb_stb      (i_wb_stb),
        .o_wb_dat      (o_wb_dat),
        .o_wb_ack      (o_wb_ack),
        .i_vga_clk     (i_vga_clk),
        .o_vga_v_sync  (o_vga_v_sync),
        .o_vga_h_sync  (o_vga_h_sync),
        .o_vga_red     (o_vga_red),
        .o_vga_green   (o_vga_green),
        .o_vga_blue    (o_vga_blue),
        .o_vga_vid_en  (o_vga_vid_en));

endmodule
