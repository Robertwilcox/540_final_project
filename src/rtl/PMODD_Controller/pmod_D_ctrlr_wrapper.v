/*
* Author: Ibrahim Binmahfood, Robert Wilcox, and Mohamed Gnedi
* ECE540, Kravitz
* Final Project, PMOD D Controller - wrapper
* 11/26/2023
*
* Platform: RVfpga on Boolean Board
* Description: Wraps the system verilog rtl module 'pmod_D_ctrlr' into a verilog
* module. Due to System Verilog not directly supported by Vivado for rtl modules
* System Verilog. The 3 bits remaining for 'i_pmod_D' and 'o_pmod_D' are left
* unconnected since they are not used.
*
*/

module pmod_D_ctrlr_wrapper
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
     // Ultrasonic Sensor (HC-SR04) signals
     input wire i_sensor_clk,   // @64 MHz
     output wire [3:0] o_pmod_D ,      // trigger pin as 0th bit
     input wire [3:0] i_pmod_D);        // echo pin as 0th bit

    pmod_D_ctrlr pmod_D_con
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
        .i_sensor_clk   (i_sensor_clk),
        .o_trigger      (o_pmod_D[0]),
        .i_echo         (i_pmod_D[0]));

endmodule
