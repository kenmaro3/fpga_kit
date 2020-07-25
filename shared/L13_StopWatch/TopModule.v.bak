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
	
	wire clk, w_sw;
	wire c1, c2; // carry signal
	wire [3:0] cnt0; // 8 base counter
	wire [3:0] cnt1; // 10 base counter
	wire [7:0] led0; // 7 segment led0 decode data
	wire [7:0] led1; // 7 segment led1 decode data
	assign clk=~w_sw;
	
	m_chattering u0(CLK1, BTN[0], w_sw); // removing KEY0 chattering
	m_universal_counter #(7) u1(clk, BTN[1], 1'b1, c1, cnt0); // 8 base counter
	m_universal_counter #(9) u2(clk, BTN[1], c1, c2, cnt1); // 10 base counter
	m_seven_segment u3(cnt0, led0);
	m_seven_segment u4(cnt1, led1);
	
	assign LED=10'h0;
	assign HEX0=led0;
	assign HEX1=led1;	
	
	

//assign LED=SW;
//assign HEX0=8'hff;
//assign HEX1=8'hff;
assign HEX2=8'hff;
assign HEX3=8'hff;
assign HEX4=8'hff;
assign HEX5=8'hff;

endmodule