module TopModule(
//	///CLOCK/////
//	input              CLK1,
//	input              CLK2,
//	//// SEG7/////
//	output     [7:0]   HEX0,
//	output     [7:0]   HEX1,
//	output     [7:0]   HEX2,
//	output     [7:0]   HEX3,
//	output     [7:0]   HEX4,
//	output     [7:0]   HEX5,
//	//// PUSH BUTTON //////
//	input      [1:0]   BTN,
//	///// LED////////
//	output     [9:0]   LED,
//	/////// SW///////////
//	input      [9:0]   SW

	input CLK1,
	input [1:0] BTN,
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
	output [9:0] LED
   
	);

	wire RST = BTN[0];
	
	wire CASEC, CAMIN;
	wire MODE, SELECT , ADJUST;
	wire SECCLR, MININC, HOURINC;
	wire SECON, MINON, HOURON;
	wire EN1HZ, SIG2HZ;
	wire [3:0] SECL, MINL, HOURL;
	wire [2:0] SECH, MINH;
	wire [1:0] HOURH;
	
	
	CNT1SEC CNT1SEC(.CLK(CLK1), .RST(RST), .EN1HZ(EN1HZ), .SIG2HZ(SIG2HZ));
	
	BTN_IN BTN_IN(.CLK(CLK1), .RST(RST), .nBIN(KEY), .BOUT({MODE, SELECT, ADJUST}));
						
	SECCNT SEC(.CLK(CLK1), .RST(RST), .EN(EN1HZ), .CLR(SECCLR), 
					.QH(SECH), QL(SECL), .CA(CAMIN));
	MINCNT MIN(.CLK(CLK1), .RST(RST), .EN(CASEC), .INC(MININC),
					.QH(MINH), .QL(MINL), .CA(CAMIN));
	HOURCNT HOUR(.CLK(CLK1), .RST(RST), .EN(CAMIN), .INC(HOURINC),
					.QH(HOURH), .QL(HOURL));
	
	STATE STATE(.CLK(CLK1), .RST(RST),  .SIG2HZ(SIG2HZ),
					.MODE(MODE), .SELECT(SELECT), .ADJUST(ADJUST),
					.SECCLR(SECCLR), .MININC(MININC), .HOURINC(HOUINC),
					.SECON(SECON), .MINON(MINON), .HOURON(HOURON));
					
	SEG7DEC SL(.DIN(SECL), .EN(SECON), .nHEX(HEX0));
	SEG7DEC SH(.DIN({1'b0, SECH}), .EN(SECON), .nHEX(HEX1));
	SEG7DEC ML(.DIN(MINL), .EN(MINON), .nHEX(HEX2));
	SEG7DEC MH(.DIN({1'b0, MINH}), .EN(MINON), .nHEX(HEX3));
	SEG7DEC HL(.DIN(HOURL), .EN(HOURON), .nHEX(HEX4));
	SEG7DEC HH(.DIN({2'b00, HOURH}), .EN(HOURON), .nHEX(HEX5));
	
endmodule
	
	
	