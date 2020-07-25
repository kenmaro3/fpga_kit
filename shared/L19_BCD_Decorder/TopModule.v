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
	
	wire [11:0] bcd;
	assign LED=10'h0;
	
	m_bcd_decorder u0(SW[7:0], bcd);
	m_seven_segment u1(bcd[3:0], HEX0);
	m_seven_segment u2(bcd[7:4], HEX1);
	m_seven_segment u3(bcd[11:8], HEX2);
	assign HEX3=8'hff;
	m_seven_segment u4(SW[3:0], HEX4);
	m_seven_segment u5(SW[7:4], HEX5);
	


endmodule

//module m_seven_segment(input [3:0] idat, output [7:0] odat);
//	parameter dot=1'b1;
//	function [7:0] LedDec;
//	input [3:0] num;
//	begin
//		case(num)
//			4'h0: LedDec=8'b11000000;
//			4'h1: LedDec=8'b11111001;
//			4'h2: LedDec=8'b10100100;
//			4'h3: LedDec=8'b10110000;
//			4'h4: LedDec=8'b10011001;
//			4'h5: LedDec=8'b10010010;
//			4'h6: LedDec=8'b10000010;
//			4'h7: LedDec=8'b11111000;
//			4'h8: LedDec=8'b10000000;
//			4'h9: LedDec=8'b10011000;
//			4'ha: LedDec=8'b10001000;
//			4'hb: LedDec=8'b10000011;
//			4'hc: LedDec=8'b10100111;
//			4'hd: LedDec=8'b10100001;
//			4'he: LedDec=8'b10000110;
//			4'hf: LedDec=8'b10001110;
//			default: LedDec=8'b11111111;
//		endcase
//	end
//endfunction
//
//wire [7:0] tdat;
//assign tdat=LedDec(idat);
//assign odat={dot, tdat[6:0]};
//
//endmodule