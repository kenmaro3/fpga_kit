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
	input      [9:0]   SW,
	
	
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B,
	output VGA_HS,
	output VGA_VS
   
	);
	
	m_character_disp u0(CLK1, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS);
	
	assign LED=SW;
	assign HEX0=8'hff;
	assign HEX1=8'hff;
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;


endmodule