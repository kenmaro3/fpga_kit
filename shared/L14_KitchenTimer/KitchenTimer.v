// create 1 sec clock
module m_1s_clk(input clk, output clk1s);
	reg [24:0] cnt;
	reg r1s;
	wire wcout;
	
	assign wcout=(cnt==25'd24999999) ? 1'b1 : 1'b0;
	assign clk1s=r1s;
	always @(posedge clk) begin
		if(wcout==1'b1) begin
			cnt=0;
			r1s=~r1s;
		end
		else begin
			cnt=cnt+1;
		end
	end
	
endmodule


// KitchenTimer module
module m_kitchen_timer(
	input clk,  // 1 sec clock
	input mode, // 0:set time, 1: run timer
	input mset_btn,  // set mininute
	input sset_btn,  // set second
	output [7:0] min,  // BCD 2 digits min
	output [7:0] sec,   // BCD 2 digists sec
	output time_end  // end time
	);
	
	
	wire [3:0] w_cb;  // carry/borrow
	wire w_cb_sm;     // carry/borrow from sec to min
	wire m_clk;       // clock for min
	wire s_clk;       // clock for sec
	wire w_cb_in;     // carry in for lowest digit
	wire r_run;       // start counting down
	wire iclk;       // internal clock
	wire clken;        // count clock effective bit
	
	assign iclk=r_run & clk;
	assign clken=~w_cb[3];
	m_rs_flipflop r0(~sset_btn, mode, r_run);
	
	assign w_cb_sm=(mode==1'b1) ? w_cb[1] : 1'b1;
	assign m_clk=(mode==1'b1) ? iclk : mset_btn;
	assign s_clk=(mode==1'b1) ?  iclk: sset_btn;
	assign w_cb_in=(mode==1'b1) ? r_run : 1'b1;
	assign time_end=(mode & w_cb[3]);
	m_up_down_counter #(9) u0(s_clk, clken, mode, w_cb_in, w_cb[0], sec[3:0]);  // 1 sec
	m_up_down_counter #(5) u1(s_clk, clken, mode, w_cb[0], w_cb[1], sec[7:4]);  // 10 sec
	m_up_down_counter #(9) u2(m_clk, clken, mode, w_cb_sm, w_cb[2], min[3:0]);  // 1 min
	m_up_down_counter #(5) u3(m_clk, clken, mode, w_cb[2], w_cb[3], min[7:4]);  // 10 min
	
endmodule














	
	
	