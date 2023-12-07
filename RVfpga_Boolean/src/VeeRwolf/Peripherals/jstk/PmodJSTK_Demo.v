`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Josh Sackos
//           Modified by Kaitlyn Franz
//              - removed MOSI interface to the LEDS
// 
// Create Date:    07/11/2012
// Module Name:    PmodJSTK_Demo 
// Project Name: 	 PmodJSTK_Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: This is a demo for the Digilent PmodJSTK. Data is sent and received
//					 to and from the PmodJSTK at a frequency of 5Hz, and positional 
//					 data is displayed on the seven segment display (SSD). The positional
//					 data of the joystick ranges from 0 to 1023 in both the X and Y
//					 directions. Only one coordinate can be displayed on the SSD at a
//					 time, therefore switch SW0 is used to select which coordinate's data
//	   			 to display. The status of the buttons on the PmodJSTK are
//					 displayed on LD2, LD1, and LD0 on the Nexys3. The LEDs will
//					 illuminate when a button is pressed. Switches SW2 and SW1 on the
//					 Nexys3 will turn on LD1 and LD2 on the PmodJSTK respectively. Button
//					 BTND on the Nexys3 is used for resetting the demo. The PmodJSTK
//					 connects to pins [4:1] on port JA on the Nexys3. SPI mode 0 is used
//					 for communication between the PmodJSTK and the Nexys3.
//
//					 NOTE: The digits on the SSD may at times appear to flicker, this
//						    is due to small pertebations in the positional data being read
//							 by the PmodJSTK's ADC. To reduce the flicker simply reduce
//							 the rate at which the data being displayed is updated.
//
// Revision History: 
// 						Revision 0.01 - File Created (Josh Sackos)
//////////////////////////////////////////////////////////////////////////////////


// ============================================================================== 
// 										  Define Module
// ==============================================================================
module PmodJSTK_Demo(
		// WISHBONE Interface
			wb_clk_i, wb_rst_i, wb_cyc_i, wb_adr_i, wb_dat_i, wb_sel_i, wb_we_i, wb_stb_i,
			wb_dat_o, wb_ack_o, wb_err_o, 
	
		// Joystick 
			MISO,
			SS,
			SCLK
    );

//
// WISHBONE Interface
//
	input             	wb_clk_i;	// Clock
	input             	wb_rst_i;	// Reset
	input             	wb_cyc_i;	// cycle valid input
	input   [31:0]		wb_adr_i;	// address bus inputs
	input   [31:0]		wb_dat_i;	// input data bus
	input	[3:0]	    wb_sel_i;	// byte select inputs
	input             	wb_we_i;	// indicates write transfer
	input             	wb_stb_i;	// strobe input
	output  [31:0]  	wb_dat_o;	// output data bus
	output            	wb_ack_o;	// normal termination
	output            	wb_err_o;	// termination w/ error

// ===========================================================================
// 										Port Declarations
// ===========================================================================

	input MISO;						// Master in slave out
	output SS;						// Slave select, active low
	output SCLK;					// Serial clock

	// ===========================================================================
	// 							  Parameters, Regsiters, and Wires
	// ===========================================================================
	wire SCLK;					// Serial clock that controls communication

	// Signal to send/receive data to/from PmodJSTK
	wire sndRec;

	// Data read from PmodJSTK
	wire [39:0] jstkData;

	// ===========================================================================
	// 										Implementation
	// ===========================================================================

			
			//-----------------------------------------------
			//  	  			PmodJSTK Interface
			//-----------------------------------------------
			PmodJSTK PmodJSTK_Int(
					.CLK(wb_clk_i),
					.RST(wb_rst_i),
					.sndRec(sndRec),
					.MISO(MISO),
					.SS(SS),
					.SCLK(SCLK),
					.DOUT(jstkData)
			);
						
			

			//-----------------------------------------------
			//  			 Send Receive Generator
			//-----------------------------------------------
			ClkDiv_5Hz genSndRec(
					.CLK(wb_clk_i),
					.RST(wb_rst_i),
					.CLKOUT(sndRec)
			);
			

		// store position of x
		//assign x_data = {jstkData[9:8],jstkData[23:16]};
			
		// store position of y
		//assign y_data = {jstkData[25:24],jstkData[39:32]};
		
		reg wb_ack_ff;
		//==================================================================================
		reg [31:0] wb_jstk_reg, wb_jstk_reg2;
		always @(posedge wb_clk_i, posedge wb_rst_i) begin
			if (wb_rst_i) begin
				wb_jstk_reg = 32'h00 ;
				wb_jstk_reg2 = 32'h00;
				wb_ack_ff = 0 ;
			end
			else begin
				case (wb_adr_i[5:2])
					0: wb_jstk_reg 	= wb_ack_ff && wb_we_i ? wb_dat_i : wb_jstk_reg;
					1: wb_jstk_reg2 = wb_ack_ff && wb_we_i ? wb_dat_i : wb_jstk_reg2;
				endcase
				// Ensure 1 wait state even for back to back host requests
				wb_ack_ff = ! wb_ack_ff & wb_stb_i & wb_cyc_i;
			end
		end
		assign wb_ack_o = wb_ack_ff;
		assign wb_dat_o = (wb_adr_i[5:2]==0) ? jstkData[39:8]: wb_jstk_reg2;
		//==================================================================================

endmodule
