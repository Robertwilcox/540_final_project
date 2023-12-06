// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//v
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
// Function: VeeRwolf toplevel for RealDigital BooleanBoard
// Comments:Comments: Added functionality for 4 pushbuttons, linked up to a second
//           instance of the gpio module, gpio2. 
//                                  - Robert wilcox (wilcox6@pdx.edu) 10/28/23
//           Added functionality for 6 RGBs, 2 each fo Red, Green, and Blue
//           controlled by a new peripheral module, rgb_top
//                                  - Robert wilcox (wilcox6@pdx.edu) 11/3/23
//           Added functionality for vga-HDMI control
//                                  - Robert Wilcox (wilcox6@pdx.edu) 11/20/23
//
//*************************** *****************************************************

`default_nettype none
module rvfpgaboolean
  #(parameter bootrom_file = "boot_main.mem")
   (input wire 	       clk,
    input wire 	       i_uart_rx,
    output wire        o_uart_tx,
    inout  wire [15:0]  i_sw,
    output reg  [15:0]  o_led,
    inout wire [3:0]    i_btn,
    output reg [7:0]   AN,
    output reg         CA, CB, CC, CD, CE, CF, CG, CA_1, CB_1, CC_1, CD_1, CE_1, CF_1, CG_1,
    output reg         RGB0_R, RGB0_G, RGB0_B, RGB1_R, RGB1_G, RGB1_B,
    output wire        TMDS_CLK_P, TMDS_CLK_N, TXN0, TXP0, TXN1, TXP1, TXN2, TXP2,
    output wire        SERVO_PWM 
    );


   wire [67:0]         gpio_out;

   localparam RAM_SIZE     = 32'h10000;

   wire         clk_core;
   wire         rst_core;
   wire         vga_clk;
   wire         vga_clk_x5;
   wire         clk_locked;
   wire         vga_hsync;
   wire         vga_vsync;
   wire [3:0]   vga_R;
   wire [3:0]   vga_G;
   wire [3:0]   vga_B;
   wire         vga_VDE;

   clk_gen_boolean
   clk_gen
     (.i_clk (clk),           // 100MHz
      .i_rst (1'b0),
      .o_clk_core (clk_core),
      .o_rst_core (rst_core));
      
      
clk_wiz_2 clk_wiz
   (
    // Clock out ports
    .vga_clk        (vga_clk),       // output vga_clk (25.2 MHz)
    .vga_clk_x5     (vga_clk_x5),    // output vga_clk_x5 (126 MHz)

    // Status and control signals
    .reset          (1'b0),      // input reset
    .locked         (clk_locked),    // output locked

   // Clock in ports
    .clk_in1        (clk)            // input clk_in1
);



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
       .clk_freq_hz  (32'd25_000_000))
   veerwolf
     (.clk                 (clk_core),
      .vga_clk             (vga_clk),         // VGA clk
      .rstn                (~rst_core),
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
      .io_data             ({i_sw[15:0],gpio_out[15:0]}),
      .io_data2            (i_btn),
      .AN (AN),
      .Digits_Bits ({CA,CB,CC,CD,CE,CF,CG}),
      .RGBs          ({RGB1_R,RGB1_G,RGB1_B,RGB0_R,RGB0_G,RGB0_B}),
      .vga_hsync                     (vga_hsync),
      .vga_vsync                     (vga_vsync),
      .vga_R                         (vga_R),
      .vga_G                         (vga_G),
      .vga_B                         (vga_B),
      .vga_VDE                       (vga_VDE),
      .servo_pwm_out                 (SERVO_PWM)
      );

     // Instantiation of hdmi_tx_v1_0
    hdmi_tx_v1_0 #(
    .C_RED_WIDTH            (4),               // Set the width of the Red channel
    .C_GREEN_WIDTH          (4),               // Set the width of the Green channel
    .C_BLUE_WIDTH           (4)                // Set the width of the Blue channel
    ) hdmi_tx_instance (
    .pix_clk                (vga_clk),         // Connect to your pixel clock
    .pix_clkx5              (vga_clk_x5),      // Connect to your 5x pixel clock
    .pix_clk_locked         (clk_locked),      // Connect to your pixel clock locked signal
    .rst                    (1'b0),        // Connect to your reset signal

    // Video input ports
    .red                    (vga_R),       // Connect to your Red video data
    .green                  (vga_G),       // Connect to your Green video data
    .blue                   (vga_B),       // Connect to your Blue video data
    .hsync                  (vga_hsync),   // Connect to your Hsync data
    .vsync                  (vga_vsync),   // Connect to your Vsync data
    .vde                    (vga_VDE),     // Connect to your Video Data Enable


    // HDMI output ports
    .TMDS_CLK_P             (TMDS_CLK_P),      // Connect to your HDMI/DVI Clock Positive
    .TMDS_CLK_N             (TMDS_CLK_N),      // Connect to your HDMI/DVI Clock Negative
    .TMDS_DATA_P            ({TXP2,TXP1,TXP0}),     // Connect to your HDMI/DVI Data Positive
    .TMDS_DATA_N            ({TXN2,TXN1,TXN0})      // Connect to your HDMI/DVI Data Negative
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
