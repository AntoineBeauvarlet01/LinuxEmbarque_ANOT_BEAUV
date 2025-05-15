	qsys u0 (
		.vid_clk_to_the_alt_vip_itc_0             (<connected-to-vid_clk_to_the_alt_vip_itc_0>),             //       alt_vip_itc_0_clocked_video.vid_clk
		.vid_data_from_the_alt_vip_itc_0          (<connected-to-vid_data_from_the_alt_vip_itc_0>),          //                                  .vid_data
		.underflow_from_the_alt_vip_itc_0         (<connected-to-underflow_from_the_alt_vip_itc_0>),         //                                  .underflow
		.vid_datavalid_from_the_alt_vip_itc_0     (<connected-to-vid_datavalid_from_the_alt_vip_itc_0>),     //                                  .vid_datavalid
		.vid_v_sync_from_the_alt_vip_itc_0        (<connected-to-vid_v_sync_from_the_alt_vip_itc_0>),        //                                  .vid_v_sync
		.vid_h_sync_from_the_alt_vip_itc_0        (<connected-to-vid_h_sync_from_the_alt_vip_itc_0>),        //                                  .vid_h_sync
		.vid_f_from_the_alt_vip_itc_0             (<connected-to-vid_f_from_the_alt_vip_itc_0>),             //                                  .vid_f
		.vid_h_from_the_alt_vip_itc_0             (<connected-to-vid_h_from_the_alt_vip_itc_0>),             //                                  .vid_h
		.vid_v_from_the_alt_vip_itc_0             (<connected-to-vid_v_from_the_alt_vip_itc_0>),             //                                  .vid_v
		.clk_50                                   (<connected-to-clk_50>),                                   //                     clk_50_clk_in.clk
		.reset_n                                  (<connected-to-reset_n>),                                  //               clk_50_clk_in_reset.reset_n
		.in_port_to_the_key                       (<connected-to-in_port_to_the_key>),                       //           key_external_connection.export
		.lcd_touch_int_external_connection_export (<connected-to-lcd_touch_int_external_connection_export>), // lcd_touch_int_external_connection.export
		.out_port_from_the_led                    (<connected-to-out_port_from_the_led>),                    //           led_external_connection.export
		.mpu_i2c_opencores_export_scl_pad_io      (<connected-to-mpu_i2c_opencores_export_scl_pad_io>),      //          mpu_i2c_opencores_export.scl_pad_io
		.mpu_i2c_opencores_export_sda_pad_io      (<connected-to-mpu_i2c_opencores_export_sda_pad_io>),      //                                  .sda_pad_io
		.mpu_int_external_connection_export       (<connected-to-mpu_int_external_connection_export>),       //       mpu_int_external_connection.export
		.pll_sdram_clk                            (<connected-to-pll_sdram_clk>),                            //                         pll_sdram.clk
		.zs_addr_from_the_sdram                   (<connected-to-zs_addr_from_the_sdram>),                   //                        sdram_wire.addr
		.zs_ba_from_the_sdram                     (<connected-to-zs_ba_from_the_sdram>),                     //                                  .ba
		.zs_cas_n_from_the_sdram                  (<connected-to-zs_cas_n_from_the_sdram>),                  //                                  .cas_n
		.zs_cke_from_the_sdram                    (<connected-to-zs_cke_from_the_sdram>),                    //                                  .cke
		.zs_cs_n_from_the_sdram                   (<connected-to-zs_cs_n_from_the_sdram>),                   //                                  .cs_n
		.zs_dq_to_and_from_the_sdram              (<connected-to-zs_dq_to_and_from_the_sdram>),              //                                  .dq
		.zs_dqm_from_the_sdram                    (<connected-to-zs_dqm_from_the_sdram>),                    //                                  .dqm
		.zs_ras_n_from_the_sdram                  (<connected-to-zs_ras_n_from_the_sdram>),                  //                                  .ras_n
		.zs_we_n_from_the_sdram                   (<connected-to-zs_we_n_from_the_sdram>),                   //                                  .we_n
		.in_port_to_the_sw                        (<connected-to-in_port_to_the_sw>),                        //            sw_external_connection.export
		.touch_i2c_opencores_export_scl_pad_io    (<connected-to-touch_i2c_opencores_export_scl_pad_io>),    //        touch_i2c_opencores_export.scl_pad_io
		.touch_i2c_opencores_export_sda_pad_io    (<connected-to-touch_i2c_opencores_export_sda_pad_io>),    //                                  .sda_pad_io
		.touch_int_n_external_connection_export   (<connected-to-touch_int_n_external_connection_export>)    //   touch_int_n_external_connection.export
	);

