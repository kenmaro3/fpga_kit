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
	
	wire button; // switch data after removing chattering
	wire clk;  // clock for counter
	wire [7:0] wq; // bcd counter outpu data
	// 7 segment led wire
	wire [7:0] seg0;
	wire [7:0] seg1;
	
	assign clk = ~button;
	m_chattering u0(CLK1, BTN[0], button);
	m_bcd_counter u1(clk, BTN[1], wq);
	m_seven_segment u2(wq[3:0], seq0);
	m_seven_segment u3(wq[7:4], seg1);
	
	assign LED = {2'h0, wq};

//assign LED=SW;
assign HEX0=seg0;
assign HEX1=seg1;
assign HEX2=8'hff;
assign HEX3=8'hff;
assign HEX4=8'hff;
assign HEX5=8'hff;

endmodule