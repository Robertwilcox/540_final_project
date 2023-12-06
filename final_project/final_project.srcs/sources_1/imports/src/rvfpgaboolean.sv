// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//********************************************************************************
// $Id$
//
// Function: VeeRwolf toplevel for Nexys A7 board
// Comments:
// Modification: 
// - Instantiated 'hdmi_tx_v1_0' and generated 'clk_wz_0' modules. Added the
// o_hdmi_clk and o_hdmi_d signals to portlist. Created vga signals interfaced
// from clk_wz_0 and hdmi_tx_v1_0 and veerwolf_core modules.
//  By: Ibrahim Binmahfood and Mohamed Gnedi
//  Date: 11/11/2023
//
// - Changed the 'clk_freq_hz' parameter in veerwolf instatiation to 25MHz.
//  By:   Ibrahim Binmahfood and Mohamed Gnedi
//  Date: 11/08/2023
//
// - Added output ports 'o_rgb0' and 'o_rgb1' for two RGB LEDs on board. These
//  signals connect in veerwolf_core module
//  By:   Ibrahim Binmahfood
//  Date: 11/03/2023
//
// - Added bidirectional input port 'i_bttn' for the buttons on
//  board. Connected 'i_bttn' to veerwolf_core by name to signal 'io_data1'
//  By:   Ibrahim Binmahfood
//  Date: 11/1/2023
//  
//
//********************************************************************************

`default_nettype none
module rvfpgaboolean
  #(parameter bootrom_file = "boot_main.mem")
   (input wire         clk,
    input wire         i_uart_rx,
    output wire        o_uart_tx, 

    // PMOD D Signals
    input wire  [3:0]    i_pmodD,          // PINS: N4, N5, T3, R4
    output wire [3:0]    o_pmodD,          // PINS: L4, K4, M4, L5

    // HDMI: Differential CLK signals
    output wire         o_hdmi_clk_n,
    output wire         o_hdmi_clk_p,

    // HDMI: 3 bit by default Differential Data signals
    output wire [2:0]   o_hdmi_d_n,
    output wire [2:0]   o_hdmi_d_p,

    inout  wire [15:0]  i_sw,
    output reg  [15:0]  o_led,
    output reg  [2:0]   o_rgb0,  // RGB0[2:0] = {B, G, R}
    output reg  [2:0]   o_rgb1,  // RGB1[2:0] = {B, G, R}
    inout  wire [3:0]   i_bttn,  // BTN[3:0]
    output reg [7:0]   AN,
    output reg         CA, CB, CC, CD, CE, CF, CG, CA_1, CB_1, CC_1, CD_1, CE_1, CF_1, CG_1,
    output wire        SERVO_PWM,
    output wire        DC_MOTOR, 

    // Final Project - Joystick lines
    output wire        SCLK,
    output wire        SS,
    input wire         MISO,
    );


   wire [63:0]         gpio_out;

   localparam RAM_SIZE     = 32'h10000;

   wire    clk_core;
   wire    rst_core;

   // PMOD D HC-SR04 sensor CLK signals
   wire    hc_sr04_sensor_clk;

   // VGA: CLK signals
   wire    vga_clk;     // pixel clock @25.20 MHz
   wire    vga_clk_x5;  // pixel clk x 5 = @126 MHz
   wire    clk_lock;    // lock the clock

   // VGA: Horizontal and Vertical Syncs with Video Enable
   wire    h_sync, v_sync, video_en;

   // VGA: 4 bit red, green, and signals
   wire [3:0] vga_r, vga_g, vga_b;


   clk_gen_boolean
   clk_gen
     (.i_clk (clk),
      .i_rst (1'b0),
      .o_clk_core (clk_core),
      .o_rst_core (rst_core));

  // CMT IP core for Sensor Signals
 clk_wiz_2 clk_div_cmt_hc_sr04
   (.clk_out1        (hc_sr04_sensor_clk),     // output clk_out1 @64 MHz
    .reset           (1'b0),
    .clk_in1         (clk));      // input clk_in1 

  // CMT IP core for VGA signals
   clk_wiz_0 clk_div_cmt_vga
      (.clk_out1     (vga_clk),           // output clk_out1 @25.20 MHz
       .clk_out2     (vga_clk_x5),        // output clk_out2 @126 MHz
       .reset        (1'b0),          
       .locked       (clk_lock),          // output clk locked
       .clk_in1      (clk));   // input clk_in1

   // VGA to HDMI Converter IP core from RealDigital
   hdmi_tx_v1_0 
     #(.C_RED_WIDTH    (4),     // Change bitwidth to 4 bit
       .C_GREEN_WIDTH  (4),
       .C_BLUE_WIDTH   (4))
    vga_2_hdmi
      (.pix_clk         (vga_clk),
       .pix_clkx5       (vga_clk_x5),
       .pix_clk_locked  (clk_lock),
       .rst             (1'b0),
       .red             (vga_r),
       .green           (vga_g),
       .blue            (vga_b),
       .hsync           (h_sync),
       .vsync           (v_sync),
       .vde             (video_en),
       .aux0_din        (4'b0),
       .aux1_din        (4'b0),
       .aux2_din        (4'b0),
       .ade             (1'b0),
       .TMDS_CLK_P      (o_hdmi_clk_p),
       .TMDS_CLK_N      (o_hdmi_clk_n),
       .TMDS_DATA_P     (o_hdmi_d_p),
       .TMDS_DATA_N     (o_hdmi_d_n));
    
   wire [5:0]  ram_awid;
   wire [31:0] ram_awaddr;
   wire [7:0]  ram_awlen;
   wire [2:0]  ram_awsize;
   wire [1:0]  ram_awburst;
   wire        ram_awlock;
   wire [3:0]  ram_awcache;
   wire [2:0]  ram_awprot;
   wire [3:0]  ram_awregion;
   wire [3:0]  ram_awqos;
   wire        ram_awvalid;
   wire        ram_awready;
   wire [5:0]  ram_arid;
   wire [31:0] ram_araddr;
   wire [7:0]  ram_arlen;
   wire [2:0]  ram_arsize;
   wire [1:0]  ram_arburst;
   wire        ram_arlock;
   wire [3:0]  ram_arcache;
   wire [2:0]  ram_arprot;
   wire [3:0]  ram_arregion;
   wire [3:0]  ram_arqos;
   wire        ram_arvalid;
   wire        ram_arready;
   wire [63:0] ram_wdata;
   wire [7:0]  ram_wstrb;
   wire        ram_wlast;
   wire        ram_wvalid;
   wire        ram_wready;
   wire [5:0]  ram_bid;
   wire [1:0]  ram_bresp;
   wire        ram_bvalid;
   wire        ram_bready;
   wire [5:0]  ram_rid;
   wire [63:0] ram_rdata;
   wire [1:0]  ram_rresp;
   wire        ram_rlast;
   wire        ram_rvalid;
   wire        ram_rready;

   axi_ram
     #(.DATA_WIDTH (64),
       .ADDR_WIDTH ($clog2(RAM_SIZE)),
       .ID_WIDTH  (`RV_LSU_BUS_TAG+3))
   ram
     (.clk       (clk_core),
      .rst       (rst_core),
      .s_axi_awid    (ram_awid),
      .s_axi_awaddr  (ram_awaddr[$clog2(RAM_SIZE)-1:0]),
      .s_axi_awlen   (ram_awlen),
      .s_axi_awsize  (ram_awsize),
      .s_axi_awburst (ram_awburst),
      .s_axi_awlock  (1'd0),
      .s_axi_awcache (4'd0),
      .s_axi_awprot  (3'd0),
      .s_axi_awvalid (ram_awvalid),
      .s_axi_awready (ram_awready),

      .s_axi_arid    (ram_arid),
      .s_axi_araddr  (ram_araddr[$clog2(RAM_SIZE)-1:0]),
      .s_axi_arlen   (ram_arlen),
      .s_axi_arsize  (ram_arsize),
      .s_axi_arburst (ram_arburst),
      .s_axi_arlock  (1'd0),
      .s_axi_arcache (4'd0),
      .s_axi_arprot  (3'd0),
      .s_axi_arvalid (ram_arvalid),
      .s_axi_arready (ram_arready),

      .s_axi_wdata  (ram_wdata),
      .s_axi_wstrb  (ram_wstrb),
      .s_axi_wlast  (ram_wlast),
      .s_axi_wvalid (ram_wvalid),
      .s_axi_wready (ram_wready),

      .s_axi_bid    (ram_bid),
      .s_axi_bresp  (ram_bresp),
      .s_axi_bvalid (ram_bvalid),
      .s_axi_bready (ram_bready),

      .s_axi_rid    (ram_rid),
      .s_axi_rdata  (ram_rdata),
      .s_axi_rresp  (ram_rresp),
      .s_axi_rlast  (ram_rlast),
      .s_axi_rvalid (ram_rvalid),
      .s_axi_rready (ram_rready));


   wire        dmi_reg_en;
   wire [6:0]  dmi_reg_addr;
   wire        dmi_reg_wr_en;
   wire [31:0] dmi_reg_wdata;
   wire [31:0] dmi_reg_rdata;
   wire        dmi_hard_reset;

   bscan_tap tap
     (.clk            (clk_core),
      .rst            (rst_core),
      .jtag_id        (31'd0),
      .dmi_reg_wdata  (dmi_reg_wdata),
      .dmi_reg_addr   (dmi_reg_addr),
      .dmi_reg_wr_en  (dmi_reg_wr_en),
      .dmi_reg_en     (dmi_reg_en),
      .dmi_reg_rdata  (dmi_reg_rdata),
      .dmi_hard_reset (dmi_hard_reset),
      .rd_status      (2'd0),
      .idle           (3'd0),
      .dmi_stat       (2'd0),
      .version        (4'd1));

   veerwolf_core
     #(.bootrom_file (bootrom_file),
       .clk_freq_hz  (32'd25_000_000))      // Increased CLK to 25 MHz
   veerwolf
     (.clk  (clk_core),
      .rstn (~rst_core),
      .dmi_reg_rdata       (dmi_reg_rdata),
      .dmi_reg_wdata       (dmi_reg_wdata),
      .dmi_reg_addr        (dmi_reg_addr),
      .dmi_reg_en          (dmi_reg_en),
      .dmi_reg_wr_en       (dmi_reg_wr_en),
      .dmi_hard_reset      (dmi_hard_reset),
      .i_uart_rx           (i_uart_rx),
      .o_uart_tx           (o_uart_tx),
      .o_ram_awid          (ram_awid),
      .o_ram_awaddr        (ram_awaddr),
      .o_ram_awlen         (ram_awlen),
      .o_ram_awsize        (ram_awsize),
      .o_ram_awburst       (ram_awburst),
      .o_ram_awlock        (ram_awlock),
      .o_ram_awcache       (ram_awcache),
      .o_ram_awprot        (ram_awprot),
      .o_ram_awregion      (ram_awregion),
      .o_ram_awqos         (ram_awqos),
      .o_ram_awvalid       (ram_awvalid),
      .i_ram_awready       (ram_awready),
      .o_ram_arid          (ram_arid),
      .o_ram_araddr        (ram_araddr),
      .o_ram_arlen         (ram_arlen),
      .o_ram_arsize        (ram_arsize),
      .o_ram_arburst       (ram_arburst),
      .o_ram_arlock        (ram_arlock),
      .o_ram_arcache       (ram_arcache),
      .o_ram_arprot        (ram_arprot),
      .o_ram_arregion      (ram_arregion),
      .o_ram_arqos         (ram_arqos),
      .o_ram_arvalid       (ram_arvalid),
      .i_ram_arready       (ram_arready),
      .o_ram_wdata         (ram_wdata),
      .o_ram_wstrb         (ram_wstrb),
      .o_ram_wlast         (ram_wlast),
      .o_ram_wvalid        (ram_wvalid),
      .i_ram_wready        (ram_wready),
      .i_ram_bid           (ram_bid),
      .i_ram_bresp         (ram_bresp),
      .i_ram_bvalid        (ram_bvalid),
      .o_ram_bready        (ram_bready),
      .i_ram_rid           (ram_rid),
      .i_ram_rdata         (ram_rdata),
      .i_ram_rresp         (ram_rresp),
      .i_ram_rlast         (ram_rlast),
      .i_ram_rvalid        (ram_rvalid),
      .o_ram_rready        (ram_rready),
      .i_ram_init_done     (1'b1),
      .i_ram_init_error    (1'b0),
       // VGA CLK signals
      .i_vga_clk           (vga_clk),           // pixel clock @25.20 MHz
       // VGA Vertical and Horizontal signals
      .o_vga_v_sync        (v_sync),             
      .o_vga_h_sync        (h_sync),
       // VGA 8 bit Output colors
      .o_vga_red           (vga_r),             
      .o_vga_green         (vga_g),
      .o_vga_blue          (vga_b),
      .o_vga_vid_en        (video_en),          // enable video
      .io_data        ({i_sw[15:0],gpio_out[15:0]}),
      .io_data1            (i_bttn),               // BTN[3:0] to GPIO1
      .rgb0                (o_rgb0),               // RGB0[2:0] to RGB Controller
      .rgb1                (o_rgb1),               // RGB1[2:0] to RGB Controller
      .i_hc_sr04_clk       (hc_sr04_sensor_clk),
      .i_pmodD             (i_pmodD),
      .o_pmodD             (o_pmodD),
      .AN (AN),
      .Digits_Bits ({CA,CB,CC,CD,CE,CF,CG}),
      .servo_pwm_out                 (SERVO_PWM),
      .dc_pwm_out                    (DC_MOTOR),
      .o_jstk_sclk    (SCLK),
      .o_jstk_cs_n    (SS),
      .i_jstk_miso    (MISO),
      .o_accel_sclk   (accel_sclk),
      .o_accel_cs_n   (o_accel_cs_n),
      .o_accel_mosi   (o_accel_mosi),
      .i_accel_miso   (i_accel_miso)
      );

   always @(posedge clk_core) begin
      o_led[15:0] <= gpio_out[15:0];
   end

   always @(posedge clk) begin
    CA_1 <= CA;
    CB_1 <= CB;
    CC_1 <= CC;
    CD_1 <= CD;
    CE_1 <= CE;
    CF_1 <= CF;
    CG_1 <= CG;
   end

endmodule
