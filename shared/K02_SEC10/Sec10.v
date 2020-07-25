module sec_10(input clk, input reset, output [7:0] dout);
	reg [24:0] cnt;
	wire en1hz = (cnt==25'd24999999) ? 1'b1 : 1'b0;
	
	reg [7:0] odat;
	
	assign dout = odat;
	
	always @(posedge clk) begin
		if(reset)
			cnt <= 26'b0;
		else if (en1hz)
			cnt <= 26'b0;
		else
			cnt <= cnt + 26'b1;
	end
	
	reg [3:0] sec;
	always @(posedge clk) begin
		if(reset)
			sec <= 4'h0;
		else if (en1hz)
			if (sec==4'h9)
				sec <= 4'h0;
			else
				sec <= sec+4'h1;
	end
	
	always @* begin
		case(sec)
			4'h0: odat = 8'b11000000;
			4'h1: odat = 8'b11111001;
			4'h2: odat = 8'b10100100;
			4'h3: odat = 8'b10110000;
			4'h4: odat = 8'b10011001;
			4'h5: odat = 8'b10010010;
			4'h6: odat = 8'b10000010;
			4'h7: odat = 8'b11011000;
			4'h8: odat = 8'b10000000;
			4'h9: odat = 8'b10010000;
			default: odat = 8'b11111111;
			
		endcase
	end
	
endmodule
		
		
		