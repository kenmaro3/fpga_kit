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
	
	wire [7:0] w_hour; 
	wire [7:0] w_min;
	wire [7:0] w_sec;
	wire clk1s;
	wire w_key0, w_key1, w_mode;
	wire mset_btn, sset_btn, mode;
	assign mset_btn=~w_key0;
	assign hset_btn=~w_key1;
	m_chattering m0(CLK1, BTN[0], w_key0);
	m_chattering m1(CLK1, BTN[1], w_key1);
	m_chattering m2(CLK1, SW[0], w_mode);
	
	m_1s_clk clk0(CLK1, clk1s);
	m_digital_watch t0(clk1s, w_mode, hset_btn, mset_btn, w_hour, w_min, w_sec);
	
	assign LED=10'h0;
	m_seven_segment #(1) u0(w_sec[3:0], HEX0);
	m_seven_segment #(1) u1(w_sec[7:4], HEX1);
	m_seven_segment #(0) u2(w_min[3:0], HEX2);
	m_seven_segment #(1) u3(w_min[7:4], HEX3);
	m_seven_segment #(0) u4(w_hour[3:0], HEX4);
	m_seven_segment #(1) u5(w_hour[7:4], HEX5);
	
	
//	wire clk10m, button, start_sw, run_led;
//	wire [7:0] w_min;
//	wire [7:0] w_sec;
//	wire [7:0] w_msec;
//	wire clk1s;
//	wire w_key0, w_key1, w_mode;
//	wire mset_btn, sset_btn, mode;
//	wire time_end;
//	assign sset_btn=~w_key0;
//	assign mset_btn=~w_key1;
	
	
//	m_chattering m0(CLK1, BTN[0], w_key0);
//	m_chattering m1(CLK1, BTN[1], w_key1);
//	m_chattering m2(CLK1, SW[0], w_mode);
//	m_1s_clk clk0(CLK1, clk1s); // clock for 1 sec
//	m_kitchen_timer t0(clk1s, w_mode, mset_btn, sset_btn, w_min, w_sec, time_end);

	
//	assign LED=(time_end==1'b1)? 10'h3ff : 10'h0;
//	m_seven_segment #(1) u0(w_sec[3:0], HEX0);
//	m_seven_segment #(1) u1(w_sec[7:4], HEX1);
//	m_seven_segment #(0) u2(w_min[3:0], HEX2);
//	m_seven_segment #(1) u3(w_min[7:4], HEX3);
//	assign HEX4=8'hff;
//	assign HEX5=8'hff;


endmodule