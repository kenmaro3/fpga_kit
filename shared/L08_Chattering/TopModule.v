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
	
	wire button; //switch data after removed chattering
	wire [3:0] wq;  //output data of 10 based counting
	wire clk; // since KEY0 becomes 0 when bushed, so need to not for counter
	assign clk=~button;
	m_chattering u0(CLK1, BTN[0] , button);
	m_dec_counter u1(clk, wq);
	assign LED={6'h0, wq};
	

//assign LED=SW;
assign HEX0=8'hff;
assign HEX1=8'hff;
assign HEX2=8'hff;
assign HEX3=8'hff;
assign HEX4=8'hff;
assign HEX5=8'hff;

endmodule