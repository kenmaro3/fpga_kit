//module TopModule(
//	///CLOCK/////
//	input              CLK1,
//	input              CLK2,
//	//// SEG7/////
////	output     [7:0]   HEX0,
////	output     [7:0]   HEX1,
////	output     [7:0]   HEX2,
////	output     [7:0]   HEX3,
////	output     [7:0]   HEX4,
////	output     [7:0]   HEX5,
//
////	//// PUSH BUTTON //////
//	input      [1:0]   BTN,
////	///// LED////////
//	output     [9:0]   LED,
////	/////// SW///////////
//	input      [9:0]   SW
//
//
//   
//	);
	

//always @* begin
//	case (SW)
//		4'h0: HEX0 = 7'b1000000;
//		4'h1: HEX0 = 7'b1111001;
//		4'h2: HEX0 = 7'b0100100;
//		4'h3: HEX0 = 7'b0110000;
//		4'h4: HEX0 = 7'b0011001;
//		4'h5: HEX0 = 7'b0010010;
//		4'h6: HEX0 = 7'b0000010;
//		4'h7: HEX0 = 7'b1011000;
//		4'h8: HEX0 = 7'b0000000;
//		4'h9: HEX0 = 7'b0010000;
//		4'ha: HEX0 = 7'b0001000;
//		4'hb: HEX0 = 7'b0000011;
//		4'hc: HEX0 = 7'b1000110;
//		4'hd: HEX0 = 7'b0100001;
//		4'he: HEX0 = 7'b0000110;
//		4'hf: HEX0 = 7'b0001110;
//		default: HEX0 = 7'b1111111;
//	endcase
//end

module TopModule(
	///CLOCK/////
	input              CLK1,
	input              CLK2,
	
	// slide switch, push switch 
	input [9:0] SW,
	input      [1:0]   BTN,
//	input [3:0] KEY
	//// SEG7/////
	output     [6:0]   HEX0,
	output     [6:0]   HEX1,
	output     [6:0]   HEX2,
	output     [6:0]   HEX3,
	output     [6:0]   HEX4,
	output     [6:0]   HEX5,
	
	// single led, ps/2
	output [9:0] LED,
	inout PS2_CLK, PS2_DAT,
	
	//vga
	output [3:0] VGA_R, VGA_G, VGA_B,
	output VGA_HS, VGA_VS,
	
	//sdram
	output DRAM_CLK, DRAM_CKE,
	output [12:0] DRAM_ADDR,
	output [1:0] DRAM_BA,
	output DRAM_CAS_N, DRAM_RAS_N,
	output DRAM_CS_N, DRAM_WE_N,
	output DRAM_UDQM, DRAM_LDQM,
	inout [15:0] DRAM_DQ,
	
	// gpio connector #0
	inout [35:0] GPIO_0
   
	);
assign RST = BTN[0];
	
	
assign HEX1=7'h7f;
assign HEX2=7'h7f;
assign HEX3=7'h7f;
assign HEX4=7'h7f;
assign HEX5=7'h7f;

nios2pio_qsys u0(
	.clk_clk (CLK1),
	.reset_reset_n (~RST),
	.pio_0_external_connection_export (HEX0),
	.pio_1_external_connection_export (SW[2:0])
);

endmodule