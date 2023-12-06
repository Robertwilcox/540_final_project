
/**
 * vga_controller.v
 *
 * @author      Robert Wilcox (wilcox6@pdx.edu)
 * @date        20-Nov-2023
 *
 * Perpipheral to control VGA signals (to be routed through VGA to HDMI converter)
 * over the wishbone bus. Peripheral includes 3 registers, one for the row-col
 * position of the character/numeral, one for what character/numeral to display,
 * and one for the char/num background colors. 
 * to access row, col write to offset 4, bits [19:10] and [9:0], respectively.
 * to access character/index data, write to offset C
 * to access color, write to offset 10. background [23:12] char/num [11:0]
 */

module vga_controller(
    input wire vga_clk,   // VGA clock
    output wire vga_hs,   // Horizontal sync output
    output wire vga_vs,   // Vertical sync output
    output reg [3:0] vga_R,   // Red signal
    output reg [3:0] vga_G,   // Blue Signal
    output reg [3:0] vga_B,   // Green signal
    output wire vga_VDE,      // High during active video frame

    // Wishbone signals
    input wire          wb_m2s_vga_clk,       // Wishbone clock
    input wire          wb_m2s_vga_rst,       // Wishbone reset (active high)
    input wire          wb_m2s_vga_cyc,       // Wishbone valid bus cycle
    input wire          wb_m2s_vga_stb,       // Wishbone valid data strobe
    input wire          wb_m2s_vga_we,        // Wishbone write enable
    input wire  [3:0]   wb_m2s_vga_sel,       // Wishbone byte select
    input wire  [31:0]   wb_m2s_vga_adr,       // Wishbone address
    input wire  [31:0]  wb_m2s_vga_dat,       // Wishbone data input
    output wire         wb_s2m_vga_ack,       // Wishbone acknowledge
    output wire [31:0]  wb_s2m_vga_dat,       // Wishbone data output
    output wire         wb_s2m_vga_err        // Wishbone error output
);
    localparam CHAR_WIDTH = 8;
    localparam CHAR_HEIGHT = 8;

    wire      [7:0]     pixels;
    wire     [11:0]     pix_row;
    wire     [11:0]     pix_col;
    reg      [31:0]     wb_vga_reg, wb_vga_reg2, wb_vga_reg3;

    reg wb_vga_ack_ff; // Ack flip-flop
   
   // Logic for assigning the registers to incoming data
   always @(posedge wb_m2s_vga_clk or posedge wb_m2s_vga_rst) begin

        // Reset
        if (wb_m2s_vga_rst) begin
            wb_vga_reg <= 32'h00;
            wb_vga_reg2 <= 32'h00;
            wb_vga_reg3 <= 32'h00;
            wb_vga_ack_ff <= 0;     // Resetting the ack flip-flop
        end

        else begin
            case (wb_m2s_vga_adr[5:2])
                4'b0001: wb_vga_reg <= wb_vga_ack_ff && wb_m2s_vga_we ? wb_m2s_vga_dat : wb_vga_reg;
                4'b0011: wb_vga_reg2 <= wb_vga_ack_ff && wb_m2s_vga_we ? wb_m2s_vga_dat : wb_vga_reg2;
                4'b0100: wb_vga_reg3 <= wb_vga_ack_ff && wb_m2s_vga_we ? wb_m2s_vga_dat : wb_vga_reg3;
            endcase

            // Ensure 1 wait state even for back to back host requests
            wb_vga_ack_ff <= !wb_vga_ack_ff & wb_m2s_vga_stb & wb_m2s_vga_cyc;
        end
    end

    // Assignment for ack signal
    assign wb_s2m_vga_ack = wb_vga_ack_ff;
    assign wb_s2m_vga_dat = (wb_m2s_vga_adr[5:2] == 4'b0001) ? wb_vga_reg :
                            (wb_m2s_vga_adr[5:2] == 4'b0011) ? wb_vga_reg2 :
                            (wb_m2s_vga_adr[5:2] == 4'b0100) ? wb_vga_reg3 : 32'h0; // Include wb_vga_reg3

    // Logic for displaying outputs
    reg [2:0] char_row;                 // Row within the character (0 to 7)
    reg [2:0] char_col;                 // Column within the character (0 to 7)

    always @(posedge vga_clk) begin
        if (vga_VDE) begin

            // Calculate the row and column within the character
            char_row <= (pix_row - wb_vga_reg[19:10]) % CHAR_HEIGHT;
            char_col <= (pix_col - wb_vga_reg[9:0]) % CHAR_WIDTH;

            // Check if the current pixel is within the bounds of the character
            if ((pix_row >= wb_vga_reg[19:10]) && (pix_row < wb_vga_reg[19:10] + CHAR_HEIGHT) &&
                (pix_col >= wb_vga_reg[9:0]) && (pix_col < wb_vga_reg[9:0] + CHAR_WIDTH)) begin

                // Use the pixels output from the chars module to set the color
                if (pixels[7 - char_col]) begin
                    vga_R <= wb_vga_reg3[3:0];
                    vga_G <= wb_vga_reg3[7:4];
                    vga_B <= wb_vga_reg3[11:8];
                end 

                else begin

                    // Interior num/char pixels. Can be changed to a color different than background for readability
                    vga_R <= wb_vga_reg3[15:12];
                    vga_G <= wb_vga_reg3[19:16];
                    vga_B <= wb_vga_reg3[23:20]; 
                end
            end 

            else begin
                // Pixels outside the character area
                vga_R <= wb_vga_reg3[15:12];
                vga_G <= wb_vga_reg3[19:16];
                vga_B <= wb_vga_reg3[23:20];
            end

        end 

        else begin

            // Default state (black) for pixels outside the active video area
            vga_R <= 4'h0;
            vga_G <= 4'h0;
            vga_B <= 4'h0;
        end
    end

    // Instantiate the Display Timing Generator (DTG)
    dtg dtg_inst (
        .clock(vga_clk),
        .rst(wb_m2s_vga_rst),
        .video_on(vga_VDE),
        .horiz_sync(vga_hs),
        .vert_sync(vga_vs),
        .pixel_row(pix_row),
        .pixel_column(pix_col)
    );

    // Instantiate chars instance to generate char/num outputs
    chars chars_inst (
        .char(wb_vga_reg2[5:0]),
        .rownum(char_row),
        .pixels(pixels)
    );
endmodule
