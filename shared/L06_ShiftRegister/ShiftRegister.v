module m_rs_flipflop(input set, input reset, output q, output nq);
	assign q=~(set & nq);
	assign nq=~(reset & q);
endmodule

module m_Shiftreg1(input clk, input d_in, output [2:0] q);
	reg [2:0] ff;
	
	assign q = ff;
	
	always @(posedge clk) begin
		ff[0] <= d_in;
		ff[1] <= ff[0];
		ff[2] <= ff[1];
	end
endmodule

module m_Shiftreg3(input clk, input d_in, output [2:0] q);
	reg [2:0] ff;
	assign q = ff;
	always @(posedge clk) begin
		ff={ff[1:0], d_in};
	end
endmodule