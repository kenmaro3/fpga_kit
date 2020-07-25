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
	
	wire w_we;
	wire w_btn0;
	wire [3:0] rdata;
	m_chattering u0(CLK1, BTN[0], w_btn0);
	assign w_we = ~w_btn0;
	
	m_ram u1(SW[9:6], SW[3:0], w_we, rdata);
	assign LED = 10'h0;
	m_seven_segment s0(rdata, HEX0);
	m_seven_segment s1(SW[3:0], HEX1);
	m_seven_segment s2(SW[9:6], HEX2);
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
// FOR L_16 ROM
	
//	reg [3:0] cnt;
//	wire w_btn0;
//	wire btn;
//	
//	m_chattering u0(CLK1, BTN[0], w_btn0);
//	assign btn=~w_btn0;
//	assign LED={6'h0, cnt};
//	
//	always @(posedge btn) begin
//		cnt = cnt+1;
//	end
//	
//	m_rom u1(cnt+5, HEX0);
//	m_rom u2(cnt+4, HEX1);
//	m_rom u3(cnt+3, HEX2);
//	m_rom u4(cnt+2, HEX3);
//	m_rom u5(cnt+1, HEX4);
//	m_rom u6(cnt, HEX5);
	



endmodule