// THIS FILE IS AUTOGENERATED BY wb_intercon_gen
// ANY MANUAL CHANGES WILL BE LOST
wire [31:0] wb_m2s_io_adr;
wire [31:0] wb_m2s_io_dat;
wire  [3:0] wb_m2s_io_sel;
wire        wb_m2s_io_we;
wire        wb_m2s_io_cyc;
wire        wb_m2s_io_stb;
wire  [2:0] wb_m2s_io_cti;
wire  [1:0] wb_m2s_io_bte;
wire [31:0] wb_s2m_io_dat;
wire        wb_s2m_io_ack;
wire        wb_s2m_io_err;
wire        wb_s2m_io_rty;
wire [31:0] wb_m2s_rom_adr;
wire [31:0] wb_m2s_rom_dat;
wire  [3:0] wb_m2s_rom_sel;
wire        wb_m2s_rom_we;
wire        wb_m2s_rom_cyc;
wire        wb_m2s_rom_stb;
wire  [2:0] wb_m2s_rom_cti;
wire  [1:0] wb_m2s_rom_bte;
wire [31:0] wb_s2m_rom_dat;
wire        wb_s2m_rom_ack;
wire        wb_s2m_rom_err;
wire        wb_s2m_rom_rty;
wire [31:0] wb_m2s_sys_adr;
wire [31:0] wb_m2s_sys_dat;
wire  [3:0] wb_m2s_sys_sel;
wire        wb_m2s_sys_we;
wire        wb_m2s_sys_cyc;
wire        wb_m2s_sys_stb;
wire  [2:0] wb_m2s_sys_cti;
wire  [1:0] wb_m2s_sys_bte;
wire [31:0] wb_s2m_sys_dat;
wire        wb_s2m_sys_ack;
wire        wb_s2m_sys_err;
wire        wb_s2m_sys_rty;
wire [31:0] wb_m2s_spi_flash_adr;
wire [31:0] wb_m2s_spi_flash_dat;
wire  [3:0] wb_m2s_spi_flash_sel;
wire        wb_m2s_spi_flash_we;
wire        wb_m2s_spi_flash_cyc;
wire        wb_m2s_spi_flash_stb;
wire  [2:0] wb_m2s_spi_flash_cti;
wire  [1:0] wb_m2s_spi_flash_bte;
wire [31:0] wb_s2m_spi_flash_dat;
wire        wb_s2m_spi_flash_ack;
wire        wb_s2m_spi_flash_err;
wire        wb_s2m_spi_flash_rty;
wire [31:0] wb_m2s_spi_accel_adr;
wire [31:0] wb_m2s_spi_accel_dat;
wire  [3:0] wb_m2s_spi_accel_sel;
wire        wb_m2s_spi_accel_we;
wire        wb_m2s_spi_accel_cyc;
wire        wb_m2s_spi_accel_stb;
wire  [2:0] wb_m2s_spi_accel_cti;
wire  [1:0] wb_m2s_spi_accel_bte;
wire [31:0] wb_s2m_spi_accel_dat;
wire        wb_s2m_spi_accel_ack;
wire        wb_s2m_spi_accel_err;
wire        wb_s2m_spi_accel_rty;
wire [31:0] wb_m2s_ptc_adr;
wire [31:0] wb_m2s_ptc_dat;
wire  [3:0] wb_m2s_ptc_sel;
wire        wb_m2s_ptc_we;
wire        wb_m2s_ptc_cyc;
wire        wb_m2s_ptc_stb;
wire  [2:0] wb_m2s_ptc_cti;
wire  [1:0] wb_m2s_ptc_bte;
wire [31:0] wb_s2m_ptc_dat;
wire        wb_s2m_ptc_ack;
wire        wb_s2m_ptc_err;
wire        wb_s2m_ptc_rty;
wire [31:0] wb_m2s_gpio_adr;
wire [31:0] wb_m2s_gpio_dat;
wire  [3:0] wb_m2s_gpio_sel;
wire        wb_m2s_gpio_we;
wire        wb_m2s_gpio_cyc;
wire        wb_m2s_gpio_stb;
wire  [2:0] wb_m2s_gpio_cti;
wire  [1:0] wb_m2s_gpio_bte;
wire [31:0] wb_s2m_gpio_dat;
wire        wb_s2m_gpio_ack;
wire        wb_s2m_gpio_err;
wire        wb_s2m_gpio_rty;
wire [31:0] wb_m2s_vga_adr;
wire [31:0] wb_m2s_vga_dat;
wire  [3:0] wb_m2s_vga_sel;
wire        wb_m2s_vga_we;
wire        wb_m2s_vga_cyc;
wire        wb_m2s_vga_stb;
wire  [2:0] wb_m2s_vga_cti;
wire  [1:0] wb_m2s_vga_bte;
wire [31:0] wb_s2m_vga_dat;
wire        wb_s2m_vga_ack;
wire        wb_s2m_vga_err;
wire        wb_s2m_vga_rty;
wire [31:0] wb_m2s_servo_adr;
wire [31:0] wb_m2s_servo_dat;
wire  [3:0] wb_m2s_servo_sel;
wire        wb_m2s_servo_we;
wire        wb_m2s_servo_cyc;
wire        wb_m2s_servo_stb;
wire  [2:0] wb_m2s_servo_cti;
wire  [1:0] wb_m2s_servo_bte;
wire [31:0] wb_s2m_servo_dat;
wire        wb_s2m_servo_ack;
wire        wb_s2m_servo_err;
wire        wb_s2m_servo_rty;
wire [31:0] wb_m2s_pmod_D_adr;
wire [31:0] wb_m2s_pmod_D_dat;
wire  [3:0] wb_m2s_pmod_D_sel;
wire        wb_m2s_pmod_D_we;
wire        wb_m2s_pmod_D_cyc;
wire        wb_m2s_pmod_D_stb;
wire  [2:0] wb_m2s_pmod_D_cti;
wire  [1:0] wb_m2s_pmod_D_bte;
wire [31:0] wb_s2m_pmod_D_dat;
wire        wb_s2m_pmod_D_ack;
wire        wb_s2m_pmod_D_err;
wire        wb_s2m_pmod_D_rty;
wire [31:0] wb_m2s_dcMotor_adr;
wire [31:0] wb_m2s_dcMotor_dat;
wire  [3:0] wb_m2s_dcMotor_sel;
wire        wb_m2s_dcMotor_we;
wire        wb_m2s_dcMotor_cyc;
wire        wb_m2s_dcMotor_stb;
wire  [2:0] wb_m2s_dcMotor_cti;
wire  [1:0] wb_m2s_dcMotor_bte;
wire [31:0] wb_s2m_dcMotor_dat;
wire        wb_s2m_dcMotor_ack;
wire        wb_s2m_dcMotor_err;
wire        wb_s2m_dcMotor_rty;
wire [31:0] wb_m2s_gpio1_adr;
wire [31:0] wb_m2s_gpio1_dat;
wire  [3:0] wb_m2s_gpio1_sel;
wire        wb_m2s_gpio1_we;
wire        wb_m2s_gpio1_cyc;
wire        wb_m2s_gpio1_stb;
wire  [2:0] wb_m2s_gpio1_cti;
wire  [1:0] wb_m2s_gpio1_bte;
wire [31:0] wb_s2m_gpio1_dat;
wire        wb_s2m_gpio1_ack;
wire        wb_s2m_gpio1_err;
wire        wb_s2m_gpio1_rty;
wire [31:0] wb_m2s_jstk_adr;
wire [31:0] wb_m2s_jstk_dat;
wire  [3:0] wb_m2s_jstk_sel;
wire        wb_m2s_jstk_we;
wire        wb_m2s_jstk_cyc;
wire        wb_m2s_jstk_stb;
wire  [2:0] wb_m2s_jstk_cti;
wire  [1:0] wb_m2s_jstk_bte;
wire [31:0] wb_s2m_jstk_dat;
wire        wb_s2m_jstk_ack;
wire        wb_s2m_jstk_err;
wire        wb_s2m_jstk_rty;
wire [31:0] wb_m2s_rgb_adr;
wire [31:0] wb_m2s_rgb_dat;
wire  [3:0] wb_m2s_rgb_sel;
wire        wb_m2s_rgb_we;
wire        wb_m2s_rgb_cyc;
wire        wb_m2s_rgb_stb;
wire  [2:0] wb_m2s_rgb_cti;
wire  [1:0] wb_m2s_rgb_bte;
wire [31:0] wb_s2m_rgb_dat;
wire        wb_s2m_rgb_ack;
wire        wb_s2m_rgb_err;
wire        wb_s2m_rgb_rty;
wire [31:0] wb_m2s_uart_adr;
wire [31:0] wb_m2s_uart_dat;
wire  [3:0] wb_m2s_uart_sel;
wire        wb_m2s_uart_we;
wire        wb_m2s_uart_cyc;
wire        wb_m2s_uart_stb;
wire  [2:0] wb_m2s_uart_cti;
wire  [1:0] wb_m2s_uart_bte;
wire [31:0] wb_s2m_uart_dat;
wire        wb_s2m_uart_ack;
wire        wb_s2m_uart_err;
wire        wb_s2m_uart_rty;

wb_intercon wb_intercon0
   (.wb_clk_i           (wb_clk),
    .wb_rst_i           (wb_rst),
    .wb_io_adr_i        (wb_m2s_io_adr),
    .wb_io_dat_i        (wb_m2s_io_dat),
    .wb_io_sel_i        (wb_m2s_io_sel),
    .wb_io_we_i         (wb_m2s_io_we),
    .wb_io_cyc_i        (wb_m2s_io_cyc),
    .wb_io_stb_i        (wb_m2s_io_stb),
    .wb_io_cti_i        (wb_m2s_io_cti),
    .wb_io_bte_i        (wb_m2s_io_bte),
    .wb_io_dat_o        (wb_s2m_io_dat),
    .wb_io_ack_o        (wb_s2m_io_ack),
    .wb_io_err_o        (wb_s2m_io_err),
    .wb_io_rty_o        (wb_s2m_io_rty),
    .wb_rom_adr_o       (wb_m2s_rom_adr),
    .wb_rom_dat_o       (wb_m2s_rom_dat),
    .wb_rom_sel_o       (wb_m2s_rom_sel),
    .wb_rom_we_o        (wb_m2s_rom_we),
    .wb_rom_cyc_o       (wb_m2s_rom_cyc),
    .wb_rom_stb_o       (wb_m2s_rom_stb),
    .wb_rom_cti_o       (wb_m2s_rom_cti),
    .wb_rom_bte_o       (wb_m2s_rom_bte),
    .wb_rom_dat_i       (wb_s2m_rom_dat),
    .wb_rom_ack_i       (wb_s2m_rom_ack),
    .wb_rom_err_i       (wb_s2m_rom_err),
    .wb_rom_rty_i       (wb_s2m_rom_rty),
    .wb_sys_adr_o       (wb_m2s_sys_adr),
    .wb_sys_dat_o       (wb_m2s_sys_dat),
    .wb_sys_sel_o       (wb_m2s_sys_sel),
    .wb_sys_we_o        (wb_m2s_sys_we),
    .wb_sys_cyc_o       (wb_m2s_sys_cyc),
    .wb_sys_stb_o       (wb_m2s_sys_stb),
    .wb_sys_cti_o       (wb_m2s_sys_cti),
    .wb_sys_bte_o       (wb_m2s_sys_bte),
    .wb_sys_dat_i       (wb_s2m_sys_dat),
    .wb_sys_ack_i       (wb_s2m_sys_ack),
    .wb_sys_err_i       (wb_s2m_sys_err),
    .wb_sys_rty_i       (wb_s2m_sys_rty),
    .wb_spi_flash_adr_o (wb_m2s_spi_flash_adr),
    .wb_spi_flash_dat_o (wb_m2s_spi_flash_dat),
    .wb_spi_flash_sel_o (wb_m2s_spi_flash_sel),
    .wb_spi_flash_we_o  (wb_m2s_spi_flash_we),
    .wb_spi_flash_cyc_o (wb_m2s_spi_flash_cyc),
    .wb_spi_flash_stb_o (wb_m2s_spi_flash_stb),
    .wb_spi_flash_cti_o (wb_m2s_spi_flash_cti),
    .wb_spi_flash_bte_o (wb_m2s_spi_flash_bte),
    .wb_spi_flash_dat_i (wb_s2m_spi_flash_dat),
    .wb_spi_flash_ack_i (wb_s2m_spi_flash_ack),
    .wb_spi_flash_err_i (wb_s2m_spi_flash_err),
    .wb_spi_flash_rty_i (wb_s2m_spi_flash_rty),
    .wb_spi_accel_adr_o (wb_m2s_spi_accel_adr),
    .wb_spi_accel_dat_o (wb_m2s_spi_accel_dat),
    .wb_spi_accel_sel_o (wb_m2s_spi_accel_sel),
    .wb_spi_accel_we_o  (wb_m2s_spi_accel_we),
    .wb_spi_accel_cyc_o (wb_m2s_spi_accel_cyc),
    .wb_spi_accel_stb_o (wb_m2s_spi_accel_stb),
    .wb_spi_accel_cti_o (wb_m2s_spi_accel_cti),
    .wb_spi_accel_bte_o (wb_m2s_spi_accel_bte),
    .wb_spi_accel_dat_i (wb_s2m_spi_accel_dat),
    .wb_spi_accel_ack_i (wb_s2m_spi_accel_ack),
    .wb_spi_accel_err_i (wb_s2m_spi_accel_err),
    .wb_spi_accel_rty_i (wb_s2m_spi_accel_rty),
    .wb_ptc_adr_o       (wb_m2s_ptc_adr),
    .wb_ptc_dat_o       (wb_m2s_ptc_dat),
    .wb_ptc_sel_o       (wb_m2s_ptc_sel),
    .wb_ptc_we_o        (wb_m2s_ptc_we),
    .wb_ptc_cyc_o       (wb_m2s_ptc_cyc),
    .wb_ptc_stb_o       (wb_m2s_ptc_stb),
    .wb_ptc_cti_o       (wb_m2s_ptc_cti),
    .wb_ptc_bte_o       (wb_m2s_ptc_bte),
    .wb_ptc_dat_i       (wb_s2m_ptc_dat),
    .wb_ptc_ack_i       (wb_s2m_ptc_ack),
    .wb_ptc_err_i       (wb_s2m_ptc_err),
    .wb_ptc_rty_i       (wb_s2m_ptc_rty),
    .wb_gpio_adr_o      (wb_m2s_gpio_adr),
    .wb_gpio_dat_o      (wb_m2s_gpio_dat),
    .wb_gpio_sel_o      (wb_m2s_gpio_sel),
    .wb_gpio_we_o       (wb_m2s_gpio_we),
    .wb_gpio_cyc_o      (wb_m2s_gpio_cyc),
    .wb_gpio_stb_o      (wb_m2s_gpio_stb),
    .wb_gpio_cti_o      (wb_m2s_gpio_cti),
    .wb_gpio_bte_o      (wb_m2s_gpio_bte),
    .wb_gpio_dat_i      (wb_s2m_gpio_dat),
    .wb_gpio_ack_i      (wb_s2m_gpio_ack),
    .wb_gpio_err_i      (wb_s2m_gpio_err),
    .wb_gpio_rty_i      (wb_s2m_gpio_rty),
    .wb_vga_adr_o       (wb_m2s_vga_adr),
    .wb_vga_dat_o       (wb_m2s_vga_dat),
    .wb_vga_sel_o       (wb_m2s_vga_sel),
    .wb_vga_we_o        (wb_m2s_vga_we),
    .wb_vga_cyc_o       (wb_m2s_vga_cyc),
    .wb_vga_stb_o       (wb_m2s_vga_stb),
    .wb_vga_cti_o       (wb_m2s_vga_cti),
    .wb_vga_bte_o       (wb_m2s_vga_bte),
    .wb_vga_dat_i       (wb_s2m_vga_dat),
    .wb_vga_ack_i       (wb_s2m_vga_ack),
    .wb_vga_err_i       (wb_s2m_vga_err),
    .wb_vga_rty_i       (wb_s2m_vga_rty),
    .wb_servo_adr_o     (wb_m2s_servo_adr),
    .wb_servo_dat_o     (wb_m2s_servo_dat),
    .wb_servo_sel_o     (wb_m2s_servo_sel),
    .wb_servo_we_o      (wb_m2s_servo_we),
    .wb_servo_cyc_o     (wb_m2s_servo_cyc),
    .wb_servo_stb_o     (wb_m2s_servo_stb),
    .wb_servo_cti_o     (wb_m2s_servo_cti),
    .wb_servo_bte_o     (wb_m2s_servo_bte),
    .wb_servo_dat_i     (wb_s2m_servo_dat),
    .wb_servo_ack_i     (wb_s2m_servo_ack),
    .wb_servo_err_i     (wb_s2m_servo_err),
    .wb_servo_rty_i     (wb_s2m_servo_rty),
    .wb_pmod_D_adr_o    (wb_m2s_pmod_D_adr),
    .wb_pmod_D_dat_o    (wb_m2s_pmod_D_dat),
    .wb_pmod_D_sel_o    (wb_m2s_pmod_D_sel),
    .wb_pmod_D_we_o     (wb_m2s_pmod_D_we),
    .wb_pmod_D_cyc_o    (wb_m2s_pmod_D_cyc),
    .wb_pmod_D_stb_o    (wb_m2s_pmod_D_stb),
    .wb_pmod_D_cti_o    (wb_m2s_pmod_D_cti),
    .wb_pmod_D_bte_o    (wb_m2s_pmod_D_bte),
    .wb_pmod_D_dat_i    (wb_s2m_pmod_D_dat),
    .wb_pmod_D_ack_i    (wb_s2m_pmod_D_ack),
    .wb_pmod_D_err_i    (wb_s2m_pmod_D_err),
    .wb_pmod_D_rty_i    (wb_s2m_pmod_D_rty),
    .wb_dcMotor_adr_o   (wb_m2s_dcMotor_adr),
    .wb_dcMotor_dat_o   (wb_m2s_dcMotor_dat),
    .wb_dcMotor_sel_o   (wb_m2s_dcMotor_sel),
    .wb_dcMotor_we_o    (wb_m2s_dcMotor_we),
    .wb_dcMotor_cyc_o   (wb_m2s_dcMotor_cyc),
    .wb_dcMotor_stb_o   (wb_m2s_dcMotor_stb),
    .wb_dcMotor_cti_o   (wb_m2s_dcMotor_cti),
    .wb_dcMotor_bte_o   (wb_m2s_dcMotor_bte),
    .wb_dcMotor_dat_i   (wb_s2m_dcMotor_dat),
    .wb_dcMotor_ack_i   (wb_s2m_dcMotor_ack),
    .wb_dcMotor_err_i   (wb_s2m_dcMotor_err),
    .wb_dcMotor_rty_i   (wb_s2m_dcMotor_rty),
    .wb_gpio1_adr_o     (wb_m2s_gpio1_adr),
    .wb_gpio1_dat_o     (wb_m2s_gpio1_dat),
    .wb_gpio1_sel_o     (wb_m2s_gpio1_sel),
    .wb_gpio1_we_o      (wb_m2s_gpio1_we),
    .wb_gpio1_cyc_o     (wb_m2s_gpio1_cyc),
    .wb_gpio1_stb_o     (wb_m2s_gpio1_stb),
    .wb_gpio1_cti_o     (wb_m2s_gpio1_cti),
    .wb_gpio1_bte_o     (wb_m2s_gpio1_bte),
    .wb_gpio1_dat_i     (wb_s2m_gpio1_dat),
    .wb_gpio1_ack_i     (wb_s2m_gpio1_ack),
    .wb_gpio1_err_i     (wb_s2m_gpio1_err),
    .wb_gpio1_rty_i     (wb_s2m_gpio1_rty),
    .wb_jstk_adr_o      (wb_m2s_jstk_adr),
    .wb_jstk_dat_o      (wb_m2s_jstk_dat),
    .wb_jstk_sel_o      (wb_m2s_jstk_sel),
    .wb_jstk_we_o       (wb_m2s_jstk_we),
    .wb_jstk_cyc_o      (wb_m2s_jstk_cyc),
    .wb_jstk_stb_o      (wb_m2s_jstk_stb),
    .wb_jstk_cti_o      (wb_m2s_jstk_cti),
    .wb_jstk_bte_o      (wb_m2s_jstk_bte),
    .wb_jstk_dat_i      (wb_s2m_jstk_dat),
    .wb_jstk_ack_i      (wb_s2m_jstk_ack),
    .wb_jstk_err_i      (wb_s2m_jstk_err),
    .wb_jstk_rty_i      (wb_s2m_jstk_rty),
    .wb_rgb_adr_o       (wb_m2s_rgb_adr),
    .wb_rgb_dat_o       (wb_m2s_rgb_dat),
    .wb_rgb_sel_o       (wb_m2s_rgb_sel),
    .wb_rgb_we_o        (wb_m2s_rgb_we),
    .wb_rgb_cyc_o       (wb_m2s_rgb_cyc),
    .wb_rgb_stb_o       (wb_m2s_rgb_stb),
    .wb_rgb_cti_o       (wb_m2s_rgb_cti),
    .wb_rgb_bte_o       (wb_m2s_rgb_bte),
    .wb_rgb_dat_i       (wb_s2m_rgb_dat),
    .wb_rgb_ack_i       (wb_s2m_rgb_ack),
    .wb_rgb_err_i       (wb_s2m_rgb_err),
    .wb_rgb_rty_i       (wb_s2m_rgb_rty),
    .wb_uart_adr_o      (wb_m2s_uart_adr),
    .wb_uart_dat_o      (wb_m2s_uart_dat),
    .wb_uart_sel_o      (wb_m2s_uart_sel),
    .wb_uart_we_o       (wb_m2s_uart_we),
    .wb_uart_cyc_o      (wb_m2s_uart_cyc),
    .wb_uart_stb_o      (wb_m2s_uart_stb),
    .wb_uart_cti_o      (wb_m2s_uart_cti),
    .wb_uart_bte_o      (wb_m2s_uart_bte),
    .wb_uart_dat_i      (wb_s2m_uart_dat),
    .wb_uart_ack_i      (wb_s2m_uart_ack),
    .wb_uart_err_i      (wb_s2m_uart_err),
    .wb_uart_rty_i      (wb_s2m_uart_rty));

