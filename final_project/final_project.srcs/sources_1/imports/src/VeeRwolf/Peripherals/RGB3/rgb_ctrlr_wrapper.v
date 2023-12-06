/*
* Author: Ibrahim Binmahfood
* ECE540, Kravitz
* Project 1, Part 3: RGB LED Controller - wrapper
* 11/01/2023
*
* Platform: RVfpga on Boolean Board
* Description: Wraps the system verilog rtl module 'rgb_ctrlr' into a verilog
* module. Due to System Verilog not directly supported by Vivado for rtl modules
* System Verilog.
*
*/

module rgb_ctrlr_wrapper
    (input wire i_clk,
     input wire i_rst,
     // Wishbone Interface
     input wire [5:0] i_wb_adr,     // only need 6 bits for six registers
     input wire [31:0] i_wb_dat,
     input wire [3:0] i_wb_sel,     // At most need 4 select lines
     input wire i_wb_we,
     input wire i_wb_cyc,
     input wire i_wb_stb,
     output wire [31:0] o_wb_dat,   // Have 32 bit register peripherals
     output wire o_wb_ack,
     // RGB LEDs
     output wire [2:0] o_rgb0_led, // RGB[0] = B; RGB[1] = G; RGB[2] = R;
     output wire [2:0] o_rgb1_led);

    rgb_ctrlr rgbcon
       (.i_clk          (i_clk),
        .i_rst          (i_rst),
        .i_wb_adr       (i_wb_adr),
        .i_wb_dat       (i_wb_dat),
        .i_wb_sel       (i_wb_sel),
        .i_wb_we        (i_wb_we),
        .i_wb_cyc       (i_wb_cyc),
        .i_wb_stb       (i_wb_stb),
        .o_wb_dat       (o_wb_dat),
        .o_wb_ack       (o_wb_ack),
        .o_rgb0_led     (o_rgb0_led),
        .o_rgb1_led     (o_rgb1_led));

endmodule
