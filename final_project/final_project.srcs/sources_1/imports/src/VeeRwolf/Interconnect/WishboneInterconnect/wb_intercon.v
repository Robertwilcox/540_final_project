// THIS FILE IS AUTOGENERATED BY wb_intercon_gen
// ANY MANUAL CHANGES WILL BE LOST
`default_nettype wire
module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_io_adr_i,
    input  [31:0] wb_io_dat_i,
    input   [3:0] wb_io_sel_i,
    input         wb_io_we_i,
    input         wb_io_cyc_i,
    input         wb_io_stb_i,
    input   [2:0] wb_io_cti_i,
    input   [1:0] wb_io_bte_i,
    output [31:0] wb_io_dat_o,
    output        wb_io_ack_o,
    output        wb_io_err_o,
    output        wb_io_rty_o,
    output [31:0] wb_rom_adr_o,
    output [31:0] wb_rom_dat_o,
    output  [3:0] wb_rom_sel_o,
    output        wb_rom_we_o,
    output        wb_rom_cyc_o,
    output        wb_rom_stb_o,
    output  [2:0] wb_rom_cti_o,
    output  [1:0] wb_rom_bte_o,
    input  [31:0] wb_rom_dat_i,
    input         wb_rom_ack_i,
    input         wb_rom_err_i,
    input         wb_rom_rty_i,
    output [31:0] wb_sys_adr_o,
    output [31:0] wb_sys_dat_o,
    output  [3:0] wb_sys_sel_o,
    output        wb_sys_we_o,
    output        wb_sys_cyc_o,
    output        wb_sys_stb_o,
    output  [2:0] wb_sys_cti_o,
    output  [1:0] wb_sys_bte_o,
    input  [31:0] wb_sys_dat_i,
    input         wb_sys_ack_i,
    input         wb_sys_err_i,
    input         wb_sys_rty_i,
    output [31:0] wb_spi_flash_adr_o,
    output [31:0] wb_spi_flash_dat_o,
    output  [3:0] wb_spi_flash_sel_o,
    output        wb_spi_flash_we_o,
    output        wb_spi_flash_cyc_o,
    output        wb_spi_flash_stb_o,
    output  [2:0] wb_spi_flash_cti_o,
    output  [1:0] wb_spi_flash_bte_o,
    input  [31:0] wb_spi_flash_dat_i,
    input         wb_spi_flash_ack_i,
    input         wb_spi_flash_err_i,
    input         wb_spi_flash_rty_i,
    output [31:0] wb_spi_accel_adr_o,
    output [31:0] wb_spi_accel_dat_o,
    output  [3:0] wb_spi_accel_sel_o,
    output        wb_spi_accel_we_o,
    output        wb_spi_accel_cyc_o,
    output        wb_spi_accel_stb_o,
    output  [2:0] wb_spi_accel_cti_o,
    output  [1:0] wb_spi_accel_bte_o,
    input  [31:0] wb_spi_accel_dat_i,
    input         wb_spi_accel_ack_i,
    input         wb_spi_accel_err_i,
    input         wb_spi_accel_rty_i,
    output [31:0] wb_ptc_adr_o,
    output [31:0] wb_ptc_dat_o,
    output  [3:0] wb_ptc_sel_o,
    output        wb_ptc_we_o,
    output        wb_ptc_cyc_o,
    output        wb_ptc_stb_o,
    output  [2:0] wb_ptc_cti_o,
    output  [1:0] wb_ptc_bte_o,
    input  [31:0] wb_ptc_dat_i,
    input         wb_ptc_ack_i,
    input         wb_ptc_err_i,
    input         wb_ptc_rty_i,
    output [31:0] wb_gpio_adr_o,
    output [31:0] wb_gpio_dat_o,
    output  [3:0] wb_gpio_sel_o,
    output        wb_gpio_we_o,
    output        wb_gpio_cyc_o,
    output        wb_gpio_stb_o,
    output  [2:0] wb_gpio_cti_o,
    output  [1:0] wb_gpio_bte_o,
    input  [31:0] wb_gpio_dat_i,
    input         wb_gpio_ack_i,
    input         wb_gpio_err_i,
    input         wb_gpio_rty_i,
    output [31:0] wb_vga_adr_o,
    output [31:0] wb_vga_dat_o,
    output  [3:0] wb_vga_sel_o,
    output        wb_vga_we_o,
    output        wb_vga_cyc_o,
    output        wb_vga_stb_o,
    output  [2:0] wb_vga_cti_o,
    output  [1:0] wb_vga_bte_o,
    input  [31:0] wb_vga_dat_i,
    input         wb_vga_ack_i,
    input         wb_vga_err_i,
    input         wb_vga_rty_i,
    output [31:0] wb_servo_adr_o,
    output [31:0] wb_servo_dat_o,
    output  [3:0] wb_servo_sel_o,
    output        wb_servo_we_o,
    output        wb_servo_cyc_o,
    output        wb_servo_stb_o,
    output  [2:0] wb_servo_cti_o,
    output  [1:0] wb_servo_bte_o,
    input  [31:0] wb_servo_dat_i,
    input         wb_servo_ack_i,
    input         wb_servo_err_i,
    input         wb_servo_rty_i,
    output [31:0] wb_pmod_D_adr_o,
    output [31:0] wb_pmod_D_dat_o,
    output  [3:0] wb_pmod_D_sel_o,
    output        wb_pmod_D_we_o,
    output        wb_pmod_D_cyc_o,
    output        wb_pmod_D_stb_o,
    output  [2:0] wb_pmod_D_cti_o,
    output  [1:0] wb_pmod_D_bte_o,
    input  [31:0] wb_pmod_D_dat_i,
    input         wb_pmod_D_ack_i,
    input         wb_pmod_D_err_i,
    input         wb_pmod_D_rty_i,
    output [31:0] wb_dcMotor_adr_o,
    output [31:0] wb_dcMotor_dat_o,
    output  [3:0] wb_dcMotor_sel_o,
    output        wb_dcMotor_we_o,
    output        wb_dcMotor_cyc_o,
    output        wb_dcMotor_stb_o,
    output  [2:0] wb_dcMotor_cti_o,
    output  [1:0] wb_dcMotor_bte_o,
    input  [31:0] wb_dcMotor_dat_i,
    input         wb_dcMotor_ack_i,
    input         wb_dcMotor_err_i,
    input         wb_dcMotor_rty_i,
    output [31:0] wb_gpio1_adr_o,
    output [31:0] wb_gpio1_dat_o,
    output  [3:0] wb_gpio1_sel_o,
    output        wb_gpio1_we_o,
    output        wb_gpio1_cyc_o,
    output        wb_gpio1_stb_o,
    output  [2:0] wb_gpio1_cti_o,
    output  [1:0] wb_gpio1_bte_o,
    input  [31:0] wb_gpio1_dat_i,
    input         wb_gpio1_ack_i,
    input         wb_gpio1_err_i,
    input         wb_gpio1_rty_i,
    output [31:0] wb_rgb_adr_o,
    output [31:0] wb_rgb_dat_o,
    output  [3:0] wb_rgb_sel_o,
    output        wb_rgb_we_o,
    output        wb_rgb_cyc_o,
    output        wb_rgb_stb_o,
    output  [2:0] wb_rgb_cti_o,
    output  [1:0] wb_rgb_bte_o,
    input  [31:0] wb_rgb_dat_i,
    input         wb_rgb_ack_i,
    input         wb_rgb_err_i,
    input         wb_rgb_rty_i,
    output [31:0] wb_uart_adr_o,
    output [31:0] wb_uart_dat_o,
    output  [3:0] wb_uart_sel_o,
    output        wb_uart_we_o,
    output        wb_uart_cyc_o,
    output        wb_uart_stb_o,
    output  [2:0] wb_uart_cti_o,
    output  [1:0] wb_uart_bte_o,
    input  [31:0] wb_uart_dat_i,
    input         wb_uart_ack_i,
    input         wb_uart_err_i,
    input         wb_uart_rty_i);

wb_mux
  #(.num_slaves (13),
    .MATCH_ADDR ({32'h00000000, 32'h00001000, 32'h00001040, 32'h00001100, 32'h00001200, 32'h00001400, 32'h00001500, 32'h00001600, 32'h00001640, 32'h00001700, 32'h00001800, 32'h00001900, 32'h00002000}),
    .MATCH_MASK ({32'hfffff000, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hffffffc0, 32'hfffff000}))
 wb_mux_io
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_io_adr_i),
    .wbm_dat_i (wb_io_dat_i),
    .wbm_sel_i (wb_io_sel_i),
    .wbm_we_i  (wb_io_we_i),
    .wbm_cyc_i (wb_io_cyc_i),
    .wbm_stb_i (wb_io_stb_i),
    .wbm_cti_i (wb_io_cti_i),
    .wbm_bte_i (wb_io_bte_i),
    .wbm_dat_o (wb_io_dat_o),
    .wbm_ack_o (wb_io_ack_o),
    .wbm_err_o (wb_io_err_o),
    .wbm_rty_o (wb_io_rty_o),
    .wbs_adr_o ({wb_rom_adr_o, wb_sys_adr_o, wb_spi_flash_adr_o, wb_spi_accel_adr_o, wb_ptc_adr_o, wb_gpio_adr_o, wb_vga_adr_o, wb_servo_adr_o, wb_pmod_D_adr_o, wb_dcMotor_adr_o, wb_gpio1_adr_o, wb_rgb_adr_o, wb_uart_adr_o}),
    .wbs_dat_o ({wb_rom_dat_o, wb_sys_dat_o, wb_spi_flash_dat_o, wb_spi_accel_dat_o, wb_ptc_dat_o, wb_gpio_dat_o, wb_vga_dat_o, wb_servo_dat_o, wb_pmod_D_dat_o, wb_dcMotor_dat_o, wb_gpio1_dat_o, wb_rgb_dat_o, wb_uart_dat_o}),
    .wbs_sel_o ({wb_rom_sel_o, wb_sys_sel_o, wb_spi_flash_sel_o, wb_spi_accel_sel_o, wb_ptc_sel_o, wb_gpio_sel_o, wb_vga_sel_o, wb_servo_sel_o, wb_pmod_D_sel_o, wb_dcMotor_sel_o, wb_gpio1_sel_o, wb_rgb_sel_o, wb_uart_sel_o}),
    .wbs_we_o  ({wb_rom_we_o, wb_sys_we_o, wb_spi_flash_we_o, wb_spi_accel_we_o, wb_ptc_we_o, wb_gpio_we_o, wb_vga_we_o, wb_servo_we_o, wb_pmod_D_we_o, wb_dcMotor_we_o, wb_gpio1_we_o, wb_rgb_we_o, wb_uart_we_o}),
    .wbs_cyc_o ({wb_rom_cyc_o, wb_sys_cyc_o, wb_spi_flash_cyc_o, wb_spi_accel_cyc_o, wb_ptc_cyc_o, wb_gpio_cyc_o, wb_vga_cyc_o, wb_servo_cyc_o, wb_pmod_D_cyc_o, wb_dcMotor_cyc_o, wb_gpio1_cyc_o, wb_rgb_cyc_o, wb_uart_cyc_o}),
    .wbs_stb_o ({wb_rom_stb_o, wb_sys_stb_o, wb_spi_flash_stb_o, wb_spi_accel_stb_o, wb_ptc_stb_o, wb_gpio_stb_o, wb_vga_stb_o, wb_servo_stb_o, wb_pmod_D_stb_o, wb_dcMotor_stb_o, wb_gpio1_stb_o, wb_rgb_stb_o, wb_uart_stb_o}),
    .wbs_cti_o ({wb_rom_cti_o, wb_sys_cti_o, wb_spi_flash_cti_o, wb_spi_accel_cti_o, wb_ptc_cti_o, wb_gpio_cti_o, wb_vga_cti_o, wb_servo_cti_o, wb_pmod_D_cti_o, wb_dcMotor_cti_o, wb_gpio1_cti_o, wb_rgb_cti_o, wb_uart_cti_o}),
    .wbs_bte_o ({wb_rom_bte_o, wb_sys_bte_o, wb_spi_flash_bte_o, wb_spi_accel_bte_o, wb_ptc_bte_o, wb_gpio_bte_o, wb_vga_bte_o, wb_servo_bte_o, wb_pmod_D_bte_o, wb_dcMotor_bte_o, wb_gpio1_bte_o, wb_rgb_bte_o, wb_uart_bte_o}),
    .wbs_dat_i ({wb_rom_dat_i, wb_sys_dat_i, wb_spi_flash_dat_i, wb_spi_accel_dat_i, wb_ptc_dat_i, wb_gpio_dat_i, wb_vga_dat_i, wb_servo_dat_i, wb_pmod_D_dat_i, wb_dcMotor_dat_i, wb_gpio1_dat_i, wb_rgb_dat_i, wb_uart_dat_i}),
    .wbs_ack_i ({wb_rom_ack_i, wb_sys_ack_i, wb_spi_flash_ack_i, wb_spi_accel_ack_i, wb_ptc_ack_i, wb_gpio_ack_i, wb_vga_ack_i, wb_servo_ack_i, wb_pmod_D_ack_i, wb_dcMotor_ack_i, wb_gpio1_ack_i, wb_rgb_ack_i, wb_uart_ack_i}),
    .wbs_err_i ({wb_rom_err_i, wb_sys_err_i, wb_spi_flash_err_i, wb_spi_accel_err_i, wb_ptc_err_i, wb_gpio_err_i, wb_vga_err_i, wb_servo_err_i, wb_pmod_D_err_i, wb_dcMotor_err_i, wb_gpio1_err_i, wb_rgb_err_i, wb_uart_err_i}),
    .wbs_rty_i ({wb_rom_rty_i, wb_sys_rty_i, wb_spi_flash_rty_i, wb_spi_accel_rty_i, wb_ptc_rty_i, wb_gpio_rty_i, wb_vga_rty_i, wb_servo_rty_i, wb_pmod_D_rty_i, wb_dcMotor_rty_i, wb_gpio1_rty_i, wb_rgb_rty_i, wb_uart_rty_i}));

endmodule