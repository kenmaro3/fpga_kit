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
	
	input ex_sin,
	output ex_sout
   
	);
	
	wire sclk, sclk2x, sout;
	wire wbtn0, sdata;
	wire [7:0] rdat;
	
	assign ex_sout=sout;
	assign sdata=(SW[9]==1'b1) ? ex_sin : sout;
	m_clock9600 c0(CLK1, sclk2x, sclk);
	m_chattering u0(CLK1, BTN[0], wbtn0);
	m_serial_tx u1(sclk, wbtn0, SW[7:0], sout);
	m_serial_rx u2(sclk2x, sdata, rdat);
	
	assign LED=10'h0;
	m_seven_segment s0(rdat[3:0], HEX0);
	m_seven_segment s1(rdat[7:4], HEX1);
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	m_seven_segment s2(SW[3:0], HEX4);
	m_seven_segment s3(SW[7:4], HEX5);
	



endmodule