/*
 * Authors: Ibrahim Binmahfood, Mohamed Gnedi
 * ECE540, Kravitz
 * Project 2, VGA Controller - rtl module
 * 11/18/2023
 *
 * Platform: RVfpga on Boolean Board
 * Description: The 'dtg' module was implemented by Srivatsa Yogendra, John
 * Lynch and Roy Kravitz. The rtl module below instantiates 'dtg' with the
 * respective vga signals and interfaces it to the Wishbone bus. The resolution
 * is set to 640 x 480 with 25.20 MHz clock. The 'CHAR_ROM' module is
 * instantiated to access 8x8 bitmapped pixels from an ASCII buffer. There are
 * four registers that can be accessed at specific addresses. The starting row
 * and column positions can written to offset 0x4, the init_row_col_pos register. 
 * The ASCII characters can be written to offset 0xC, the ascii_data_buff register. 
 * The 'dtg' module's row and column pixel counters can be read from at offset 0x0 
 * and the pixel_num counter can be read at offset 0x08
 *
 */

module vga_ctrlr
    (input wire logic i_clk,
     input wire logic i_rst,
     // Wishbone Interface
     input wire logic [5:0] i_wb_adr,         // at require 6 bits for addresses in mind
     input wire logic [31:0] i_wb_dat,        
     input wire logic [3:0] i_wb_sel,         // at most only need 4 select lines
     input wire logic i_wb_we,
     input wire logic i_wb_cyc,
     input wire logic i_wb_stb,
     output logic [31:0] o_wb_dat,
     output logic o_wb_ack,
     // VGA CLK signal
     input wire logic   i_vga_clk,       // pixel clock @25.20 MHz
     // VGA Vertical and Horizontal signals
     output wire logic  o_vga_v_sync,
     output wire logic  o_vga_h_sync,
     // VGA 4 bit output colors
     output logic [3:0]  o_vga_red,
     output logic [3:0]  o_vga_green,
     output logic [3:0]  o_vga_blue,
     output wire logic   o_vga_vid_en);  // enable video

    // Register Write Enable:
    //
    // Only when valid bus cycle in progress AND incoming strobe AND incoming
    // write enable AND no ACK signals
    wire logic reg_we = i_wb_cyc & i_wb_stb & i_wb_we & (!o_wb_ack);

    // Register Read Enable:
    //
    // Only when valid bus cycle in progress AND incoming strobe AND no
    // incoming write enable AND no ACK signals
    wire logic reg_re = i_wb_cyc & i_wb_stb & (!i_wb_we) & (!o_wb_ack);

    // DTG's x (column) and y (row) pixel counters
    logic [11:0] x_pixel_cntr;
    logic [11:0] y_pixel_cntr;

    // Incremented every clk (i_vga_clk), when o_vga_vid_en is HI
    // IF x and y pixel counters in vertical blanking area, reset to 0
    logic [31:0] pixel_num_cntr;
    
    // 8 bit columns and 8 rows to store bitmap of ASCII [0-9] and [a-z] characters
    logic [7:0] pixel_char [0:7];        

    // Iteration variables to index through pixel_char
    (* KEEP = "TRUE"*) logic [11:0] row_iter;           // Using KEEP to avoid Vivado removing it
    (* KEEP = "TRUE"*) logic [11:0] col_iter;

    // Initial Row and Column Position Register
    logic [19:0] init_row_col_pos;

    // ASCII Data Buffer Register
    logic [7:0] ascii_data_buff;
    
    // Wishbone Peripheral Interfacing
    always_ff @(posedge i_clk) begin
        // if valid bus cycle in progress AND no ACK signal
        o_wb_ack <= i_wb_cyc & !o_wb_ack;

        if (i_rst) begin
            o_wb_ack        <= 1'b0; // if reset asserted then let ack = 0
            ascii_data_buff <= 8'h00;
        end


        // Register Write Enable asserted
        if (reg_we) begin
            // sweep through addresses
            unique case (i_wb_adr[5:2])
                // 0x04
                1: begin
                    // Column bitfield : [9:0]
                    if (i_wb_sel[0]) init_row_col_pos[9:0]     <= i_wb_dat[9:0];
                    // Row bitfield : [19:10]
                    if (i_wb_sel[1]) init_row_col_pos[19:10]   <= i_wb_dat[19:10];
                end
                // 0x0C
                3: begin
                    // Data Buffer bitfield : [7:0]
                    if (i_wb_sel[0]) ascii_data_buff[7:0]     <= i_wb_dat[7:0]; 
                end
            endcase
        end

        // Register Read Enable asserted
        if (reg_re) begin
            // sweep through addresses
            unique case (i_wb_adr[5:2])
                // 0x00     DTG: Pixel x and y counters
                0: o_wb_dat[31:0] <= {8'd0, x_pixel_cntr, y_pixel_cntr};
                // 0x08     DTG: Pixel Number Counter
                2: o_wb_dat[31:0] <= pixel_num_cntr;
            endcase
        end
    end

    // Convert the ASCII value from Data buffer to correc to pixel bit mapping
    // via character ROM
    CHAR_ROM char_rom
        (.CLK     (i_vga_clk),
         .address (ascii_data_buff),
         .data    (pixel_char));

    // Display the pixels through red, blue and green vga pins
    always_ff @(posedge i_vga_clk) begin
        // Initialize to 0
        row_iter <= 12'd0;
        col_iter <= 12'd0;
        
        // Video Enable asserted
        if (o_vga_vid_en) begin
            // When the initial row position less than row counter
            // AND
            // final row position greater than row counter.
            // AND
            // initial column position less than column counter
            // AND
            // final column position greater than column counter
            if ((init_row_col_pos[19:10] <= y_pixel_cntr)     && 
                (init_row_col_pos[19:10] + 8 >= y_pixel_cntr) && 
                (init_row_col_pos[9:0] <= x_pixel_cntr)       && 
                (init_row_col_pos[9:0] + 8 >= x_pixel_cntr)) begin

                // Find difference of position
                row_iter    <= y_pixel_cntr -  init_row_col_pos[19:10];  // row bitfield
                col_iter    <= x_pixel_cntr -  init_row_col_pos[9:0];    // column bitfield

                // Index through pixel character to find if bit is 1 or 0
                o_vga_red   = pixel_char[row_iter][col_iter] ? 4'b1111 : 4'b1111; // let it be read between characters
                o_vga_green = pixel_char[row_iter][col_iter] ? 4'b1111 : 4'b0000;
                o_vga_blue  = pixel_char[row_iter][col_iter] ? 4'b1111 : 4'b0000; 
            end
            // Pass after character RED
            else begin
                o_vga_red   = 4'b1111;
                o_vga_green = 4'b0000;
                o_vga_blue  = 4'b0000;
            end
        end

        // Set the background to RED only
        else begin
            o_vga_red   = 4'b1111;
            o_vga_green = 4'b0000;
            o_vga_blue  = 4'b0000; 
        end
    end

    dtg dtg0
       (.clock         (i_vga_clk),
        .rst           (1'b0),
        .horiz_sync    (o_vga_h_sync),
        .vert_sync     (o_vga_v_sync),
        .video_on      (o_vga_vid_en),
        .pixel_row     (y_pixel_cntr),
        .pixel_column  (x_pixel_cntr),     
        .pix_num       (pixel_num_cntr));

endmodule
