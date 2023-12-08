`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// School: Portland State University
// Student: Mohamed Gnedi
// 
// Create Date:    03/12/2023
// Module Name:    PmodJSTK_Demo
// Project Name:   veerwolf_core
// Target Devices: Boolean Board
// Credit to Engineer: Josh Sackos & Kaitlyn Franz
//
// Description: This is a demo for the Digilent PmodJSTK. Data is sent and received
//					 to and from the PmodJSTK at a frequency of 5Hz, and positional 
//					 data is displayed on the seven segment display (SSD). The positional
//					 data of the joystick ranges from 0 to 1023 in both the X and Y
//					 directions. 
//					 The PmodJSTK connects to pins {4, 2, 1} on port JA on the Boolean board.
//					 JA[1]: A14 -> SCLK
//					 JA[2]: B14 -> MISO  
//					 JA[4]: B13 -> SS
//					 SPI mode 0 is used for communication between the PmodJSTK and the Wishbone Bus.
//
// Main output: The XY data & Button presses from the joystick are sampled by the spiMode0 module within the PmodJSTK.
//		The sequence of 5 Bytes is collected in the spiCtrl and passed to the Wishbone data out line.
// 		Due to the limitation of the WB register sizes, the XY data is transferred and the buttons are skipped.
//		The 32-bits of XY data are passed to the wb_dat_o register that's accessed by the FW to process the 
//		joystick inputs.
//
// Info attached below
//////////////////////////////////////////////////////////////////////////////////
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
	reg [31:0] wb_jstk_reg, wb_jstk_reg2; // two register to be used for XY-data and button input
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
	
		// x_data = {jstkData[9:8],jstkData[23:16]}; 
		// y_data = {jstkData[25:24],jstkData[39:32]};
		// Pass the bits [39-8] of the joystick to match the size of the WB register
		assign wb_dat_o = (wb_adr_i[5:2]==0) ? jstkData[39:8]: wb_jstk_reg2;
		//==================================================================================

endmodule
