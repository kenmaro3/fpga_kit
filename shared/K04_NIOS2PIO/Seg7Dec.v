module seg_7_dec(input [3:0] sw, output [7:0] dat_out);
	
	reg [7:0] odat;
	
	assign dat_out = odat;
	
	always @* begin
		case(sw)
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
			4'ha: odat = 8'b10001000;
			4'hb: odat = 8'b10000011;
			4'hc: odat = 8'b11000110;
			4'hd: odat = 8'b10100001;
			4'he: odat = 8'b10000110;
			4'hf: odat = 8'b10001110;
			default: odat = 8'b11111111;
			
		endcase
	end
endmodule

