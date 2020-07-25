// up down counter
module m_up_down_counter(input clk, input clken, input mode, input cb_in, output cb_out, output [3:0] cnt_out);
	parameter maxcnt = 9;
	reg [3:0] cnt;
	wire w_cout, w_bout;
	
	assign cnt_out = cnt;
	assign cb_out=(mode==1'b0) ? w_cout : w_bout;
	assign w_bout=((cnt==4'h0) && (cb_in==1'b1)) ? 1'b1 : 1'b0;
	assign w_cout=((cnt==maxcnt) && (cb_in==1'b1))? 1'b1 : 1'b0;
	always @(posedge clk) begin
		if(mode==1'b0) begin
			if(cb_in==1'b1) begin
				if(cnt==maxcnt)
					cnt=0;
				else
					cnt = cnt+1;
			end
		end
		else begin
			if((cb_in==1'b1) && (clken==1'b1)) begin
				if(cnt==4'h0)
					cnt=maxcnt;
				else
					cnt=cnt-1;
			end
		end
	end

endmodule


// RS FlipFlop
//module m_rs_flipflop(input set, input reset, output q);
//	wire nq;
//	assign q=~(set & nq);
//	assign nq = ~(reset & q);
//endmodule

		
			
			
			