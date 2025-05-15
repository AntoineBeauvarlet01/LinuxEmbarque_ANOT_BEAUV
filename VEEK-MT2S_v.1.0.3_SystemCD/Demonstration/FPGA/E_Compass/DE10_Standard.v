// ============================================================================
// Copyright (c) 2016 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Thu Nov  3 15:01:20 2016
// ============================================================================


//`define ENABLE_HPS

module DE10_Standard(

      ///////// CLOCK /////////
      input              CLOCK2_50,
      input              CLOCK3_50,
      input              CLOCK4_50,
      input              CLOCK_50,

      ///////// KEY /////////
      input    [ 3: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LED /////////
      output   [ 9: 0]   LEDR,

      ///////// Seg7 /////////
      output   [ 6: 0]   HEX0,
      output   [ 6: 0]   HEX1,
      output   [ 6: 0]   HEX2,
      output   [ 6: 0]   HEX3,
      output   [ 6: 0]   HEX4,
      output   [ 6: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// Video-In /////////
      input              TD_CLK27,
      input              TD_HS,
      input              TD_VS,
      input    [ 7: 0]   TD_DATA,
      output             TD_RESET_N,

      ///////// VGA /////////
      output             VGA_CLK,
      output             VGA_HS,
      output             VGA_VS,
      output   [ 7: 0]   VGA_R,
      output   [ 7: 0]   VGA_G,
      output   [ 7: 0]   VGA_B,
      output             VGA_BLANK_N,
      output             VGA_SYNC_N,

      ///////// Audio /////////
      inout              AUD_BCLK,
      output             AUD_XCK,
      inout              AUD_ADCLRCK,
      input              AUD_ADCDAT,
      inout              AUD_DACLRCK,
      output             AUD_DACDAT,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// ADC /////////
      output             ADC_SCLK,
      input              ADC_DOUT,
      output             ADC_DIN,
      output             ADC_CONVST,

      ///////// I2C for Audio and Video-In /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      ///////// GPIO /////////
      inout    [35: 0]   GPIO,

	//////////// HSMC, HSMC connect to MTLC2 -Multi-Touch/LCD/Camera //////////
      inout 	      		CAMERA_I2C_SCL,
      inout 	      		CAMERA_I2C_SDA,
      output	      		CAMERA_PWDN_n,
      output	 [7:0]		LCD_B,
      output	      		LCD_DCLK,
      output	      		LCD_DE,
      output	      		LCD_DIM,
      output	      		LCD_DITH,
      output	 [7:0]		LCD_G,
      output	      		LCD_HSD,
      output	      		LCD_MODE,
      output	      		LCD_POWER_CTL,
      output	      		LCD_RSTB,
      output	 [7:0]		LCD_R,
      output	      		LCD_SHLR,
      output	      		LCD_UPDN,
      output	      		LCD_VSD,
      output	      		LSENSOR_ADDR_SEL,
      input 	      		LSENSOR_INT,
      inout 	      		LSENSOR_SCL,
      inout 	      		LSENSOR_SDA,
      output	      		MIPI_CS_n,
      inout 	      		MIPI_I2C_SCL,
      inout 	      		MIPI_I2C_SDA,
      output	      		MIPI_MCLK,
      input 	      		MIPI_PIXEL_CLK,
      input 	[13:0]		MIPI_PIXEL_D,
      input 	      		MIPI_PIXEL_HS,
      input 	      		MIPI_PIXEL_VS,
      output	      		MIPI_REFCLK,
      output	      		MIPI_RESET_n,
      output	      		MPU_AD0_SDO,
      output	      		MPU_CS_n,
      output	      		MPU_FSYNC,
      input 	      		MPU_INT,
      inout 	      		MPU_SCL_SCLK,
      inout 	      		MPU_SDA_SDI,
      inout 	      		TOUCH_I2C_SCL,
      inout 	      		TOUCH_I2C_SDA,
      input 	      		TOUCH_INT_n,


`ifdef ENABLE_HPS
      ///////// HPS /////////
      inout              HPS_CONV_USB_N,
      output   [14: 0]   HPS_DDR3_ADDR,
      output   [ 2: 0]   HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output   [ 3: 0]   HPS_DDR3_DM,
      inout    [31: 0]   HPS_DDR3_DQ,
      inout    [ 3: 0]   HPS_DDR3_DQS_N,
      inout    [ 3: 0]   HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input    [ 3: 0]   HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output   [ 3: 0]   HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout    [ 3: 0]   HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LCM_BK,
      inout              HPS_LCM_D_C,
      inout              HPS_LCM_RST_N,
      input              HPS_LCM_SPIM_CLK,
      output             HPS_LCM_SPIM_MOSI,
	  input 			 HPS_LCM_SPIM_MISO,
      output             HPS_LCM_SPIM_SS,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      inout              HPS_RESET_N,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout    [ 3: 0]   HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      output             HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout    [ 7: 0]   HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/


      ///////// IR /////////
      output             IRDA_TXD,
      input              IRDA_RXD
);

//=======================================================
//  REG/WIRE declarations
//=======================================================


wire reset_n;
wire video_hs;
wire video_vs;
wire video_clk;
wire video_de;
wire [7:0] video_r;
wire [7:0] video_g;
wire [7:0] video_b;

//=======================================================
//  Structural coding
//=======================================================


vga_pll vga_pll_inst(
	.rst(~KEY[0]),
	.refclk(CLOCK2_50),
	.outclk_0(video_clk), // 33.3MHz
	.locked(reset_n)
	);
	

	


    qsys u0 (
        .reset_n                                  (reset_n),                                  //               clk_50_clk_in_reset.reset_n
        .clk_50                                   (CLOCK_50),                                   //                     clk_50_clk_in.clk

        .out_port_from_the_led                    (LEDR),                    //           led_external_connection.export
        .in_port_to_the_sw                        (SW),                        //            sw_external_connection.export
        .in_port_to_the_key                       (KEY),                       //           key_external_connection.export
		  
			// sdram 
        .pll_sdram_clk                            (DRAM_CLK),                             //                         pll_sdram.clk
        .zs_addr_from_the_sdram                   (DRAM_ADDR),                   //                        sdram_wire.addr
        .zs_ba_from_the_sdram                     (DRAM_BA),                     //                                  .ba
        .zs_cas_n_from_the_sdram                  (DRAM_CAS_N),                  //                                  .cas_n
        .zs_cke_from_the_sdram                    (DRAM_CKE),                    //                                  .cke
        .zs_cs_n_from_the_sdram                   (DRAM_CS_N),                   //                                  .cs_n
        .zs_dq_to_and_from_the_sdram              (DRAM_DQ),              //                                  .dq
        .zs_dqm_from_the_sdram                    ({DRAM_UDQM,DRAM_LDQM}),                    //                                  .dqm
        .zs_ras_n_from_the_sdram                  (DRAM_RAS_N),                  //                                  .ras_n
        .zs_we_n_from_the_sdram                   (DRAM_WE_N),                   //                                  .we_n
		  
		  // display
        .vid_clk_to_the_alt_vip_itc_0             (video_clk),             //       alt_vip_itc_0_clocked_video.vid_clk
        .vid_data_from_the_alt_vip_itc_0          ({video_r, video_g, video_b}),          //                                  .vid_data
        .underflow_from_the_alt_vip_itc_0         (),         //                                  .underflow
        .vid_datavalid_from_the_alt_vip_itc_0     (video_de),     //                                  .vid_datavalid
        .vid_v_sync_from_the_alt_vip_itc_0        (video_vs),        //                                  .vid_v_sync
        .vid_h_sync_from_the_alt_vip_itc_0        (video_hs),        //                                  .vid_h_sync
        .vid_f_from_the_alt_vip_itc_0             (),             //                                  .vid_f
        .vid_h_from_the_alt_vip_itc_0             (),             //                                  .vid_h
        .vid_v_from_the_alt_vip_itc_0             (),             //                                  .vid_v
		  
		  // mpu
        .mpu_int_external_connection_export       (MPU_INT ),       //       mpu_int_external_connection.export
        .mpu_i2c_opencores_export_scl_pad_io      (MPU_SCL_SCLK),      //          mpu_i2c_opencores_export.scl_pad_io
        .mpu_i2c_opencores_export_sda_pad_io      (MPU_SDA_SDI ),      //                                  .sda_pad_io

		  // touch
        .touch_i2c_opencores_export_scl_pad_io        (TOUCH_I2C_SCL),        //            i2c_opencores_0_export.scl_pad_io
        .touch_i2c_opencores_export_sda_pad_io        (TOUCH_I2C_SDA),        //                                  .sda_pad_io
        .touch_int_n_external_connection_export	      (TOUCH_INT_n) // lcd_touch_int_external_connection.export
		  
    );

		
// vga on baord
assign {VGA_R, VGA_G, VGA_B} = {video_r, video_g, video_b};
assign VGA_BLANK_N = 1'b1;
assign VGA_SYNC_N = 1'b0;
assign VGA_HS = ~video_hs;
assign VGA_VS = ~video_vs;
assign VGA_CLK = video_clk;


// MTL - display
assign {LCD_R,LCD_G,LCD_B} = {video_r, video_g, video_b};
assign LCD_DCLK = video_clk;
assign LCD_HSD = ~video_hs;
assign LCD_VSD = ~video_vs;
//assign LCD_DE = video_de;

// lcd config
assign LCD_BLON = 1'b1;
assign LCD_ON = 1'b1;
assign LCD_MODE = 1'b0;  //HSD/VSD mode
assign LCD_RSTB = 1'b1; //NO RESET
assign LCD_DIM  = 1'b1;
assign LCD_POWER_CTL = 1'b1;
assign LCD_SHLR         = 1'b1;
assign LCD_UPDN         = 1'b0;
//assign LCD_DITH = ;

// mtlc2: mpu9250
assign MPU_AD0_SDO = 1'b0;
assign MPU_CS_n = 1'b1; // pull-high for I2C
assign MPU_FSYNC = 1'b0; 


		

endmodule
