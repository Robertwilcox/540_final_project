`timescale 1ns / 1ps

module tb_servo_controller;

    // Inputs
    reg wb_clk = 0;
    reg wb_rst = 1;
    reg wb_cyc = 0;
    reg wb_stb = 0;
    reg wb_we = 0;
    reg [3:0] wb_sel = 4'b1111;
    reg [31:0] wb_adr = 0;
    reg [31:0] wb_dat_i = 0;

    // Outputs
    wire pwm_out;
    wire wb_ack;
    wire [31:0] wb_dat_o;
    wire [31:0] debug_counter;
    wire [31:0] debug_pwm_width_reg;

    // Instantiate the Unit Under Test (UUT)
    servo_controller uut (
        .wb_clk                 (wb_clk), 
        .wb_rst                 (wb_rst), 
        .wb_cyc                 (wb_cyc), 
        .wb_stb                 (wb_stb), 
        .wb_we                  (wb_we), 
        .wb_sel                 (wb_sel), 
        .wb_adr                 (wb_adr), 
        .wb_dat_i               (wb_dat_i), 
        .pwm_out                (pwm_out), 
        .wb_ack                 (wb_ack), 
        .wb_dat_o               (wb_dat_o),
        .debug_counter          (debug_counter),
        .debug_pwm_width_reg    (debug_pwm_width_reg)
    );

    // Clock generation
    always #5 wb_clk = ~wb_clk;  // 100 MHz Clock

    // Monitor PWM output
    reg [31:0] high_time = 0;
    reg [31:0] low_time = 0;
    reg pwm_out_prev = 0;

    always @(posedge wb_clk) begin
        if (pwm_out != pwm_out_prev) begin // Detect change in PWM signal
            
            if (pwm_out == 1) begin
                
                // PWM went high, print low time and reset counter
                $display("PWM Low Time: %d ns", low_time * 10); // 10 ns per clock cycle at 100 MHz
                high_time = 0;
            end 
            else begin

                // PWM went low, print high time and reset counter
                $display("PWM High Time: %d ns", high_time * 10);
                low_time = 0;
            end
            pwm_out_prev = pwm_out;
        end 
        else begin
            
            // Increment the appropriate counter
            if (pwm_out == 1) begin
                high_time = high_time + 1;
            end 
            else begin
                low_time = low_time + 1;
            end
        end
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        wb_rst = 1; wb_cyc = 0; wb_stb = 0; wb_we = 0;
        wb_sel = 4'b1111; wb_adr = 32'h00000004; // PWM width register address
        wb_dat_i = 0;

        // Wait for global reset
        #100;
        wb_rst = 0;

        // Test with different PWM widths
        repeat (5) begin
            // Incrementing the PWM width
            wb_dat_i = wb_dat_i + 32'h00010000; // Increment by some value
            wb_cyc = 1; wb_stb = 1; wb_we = 1;

            // Wait for acknowledgment and then deassert the strobe
            wait(wb_ack == 1);
            $display("Setting PWM Width: %d, Ack Received", wb_dat_i);
            #10; wb_stb = 0; wb_cyc = 0; wb_we = 0;

            // Wait for some time to observe PWM output
            #100000000; // Adjust as needed
        end

        // End the simulation
        $display("Simulation completed");
        $finish;
    end
endmodule
