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
	
	wire clk;
	//wire [2:0] wq0;
	wire [2:0] wq1;
	//wire [2:0] wq2;
	wire [2:0] wq3;
	wire [2:0] wq;
	
	m_Shiftreg1 u1(clk, SW[0], wq1);
	m_Shiftreg3 u3(clk, SW[0], wq3);
	m_rs_flipflop u4(BTN[0], BTN[1], clk);
	
	//selector
	assign wq = ( (SW[9] == 0) && (SW[8] == 0)) ? wq1 : wq3;  
	
	assign LED={7'h0, wq};

//assign LED=SW;
assign HEX0=8'hff;
assign HEX1=8'hff;
assign HEX2=8'hff;
assign HEX3=8'hff;
assign HEX4=8'hff;
assign HEX5=8'hff;

endmodule