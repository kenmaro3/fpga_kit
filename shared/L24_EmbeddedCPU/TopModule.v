module TopModule(
	///CLOCK/////
	input              CLK1,
	input              CLK2,
	//// SEG7/////
	output     [7:0]   HEX0,
	output     [7:0]   HEX1,
	output     [7:0]   HEX2,
	output     [7:0]   HEX3,
	output     [7:0]   HEX4,
	output     [7:0]   HEX5,
	//// PUSH BUTTON //////
	input      [1:0]   BTN,
	///// LED////////
	output     [9:0]   LED,
	/////// SW///////////
	input      [9:0]   SW
   
	);
	
EmbeddedCPU u0 (
    .button_external_connection_export (BTN),
    .clk_clk                           (CLK1),
    .hex0_external_connection_export   (HEX0),
    .hex1_external_connection_export   (HEX1),
    .hex2_external_connection_export   (HEX2),
    .hex3_external_connection_export   (HEX3),
    .hex4_external_connection_export   (HEX4),
    .hex5_external_connection_export   (HEX5),
    .led_external_connection_export    (LED),
    .reset_reset_n                     (1'b1),
    .switch_external_connection_export (SW)

);


endmodule