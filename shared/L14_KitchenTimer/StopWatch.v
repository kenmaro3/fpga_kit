// 1/100 sec clock generate
module m_10ms_clk(input clk, output clk10ms);
	reg [19:0] cnt;
	reg r10ms;
	wire wcout;
	
	assign wcout=(cnt==20'd249999) ? 1'b1 : 1'b0;
	assign clk10ms=r10ms;
	always @(posedge clk) begin
		if(wcout==1'b1) begin
			cnt=0;
			r10ms=~r10ms;
		end
		else begin
			cnt = cnt+1;
		end
	end
endmodule


// stopwatch module
module m_stop_watch(
	input clk,    // 1/100 second clock
	input start_sw,   // bool switch of start/stop
	input n_reset,  // reset negative bool
	output [7:0] min,   // BCD2digists for min
	output [7:0] sec,    // BCD 2 digists for sec
	output [7:0] msec,   // BCD 2 digists for msec
	output run_led      // showing LED
	);
	
	reg r_run;
	wire [5:0] carry;
	wire [7:0] w_min;
	wire [7:0] w_sec;
	wire [7:0] w_msec;
	
	assign run_led=r_run;
	assign min=w_min;
	assign sec=w_sec;
	assign msec=w_msec;
	always @(posedge start_sw) begin
		r_run = ~r_run;
	end
	
	m_universal_counter #(9) u0(clk, n_reset, r_run, carry[0], w_msec[3:0]); // 1/100 sec
	m_universal_counter #(9) u1(clk, n_reset, carry[0],carry[1], w_msec[7:4]); // 1/10 sec
	m_universal_counter #(9) u2(clk, n_reset, carry[1],carry[2], w_sec[3:0]); // 1 sec
	m_universal_counter #(5) u3(clk, n_reset, carry[2],carry[3], w_sec[7:4]); // 10 sec
	m_universal_counter #(9) u4(clk, n_reset, carry[3],carry[4], w_min[3:0]); // 1 min
	m_universal_counter #(5) u5(clk, n_reset, carry[4],carry[5], w_min[7:4]); // 10 min
	
	endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	