module m_ram(input [3:0] adr, input [3:0] wdata, input we, output [3:0] rdata);
	reg [3:0] mem [0:15]; // 16x4bit RAM
	//read data
	assign rdata = mem[adr];
	// write data
	always @(posedge we) begin
		mem[adr] = wdata;
	end

endmodule


// removign chattering
module m_chattering(input clk, input sw_in, output sw_out);
	reg[15:0] cnt;
	reg swreg;
	wire iclk;
	
	assign sw_out=swreg;
	
	// 16 bit counter
	always @(posedge clk) begin
		cnt=cnt+1;
	end
	assign iclk=cnt[15];
	
	always @(posedge iclk) begin
		swreg=sw_in;
	end
endmodule


// 7 segment decoder
module m_seven_segment(input [3:0] idat, output [7:0] odat);
	parameter dot=1'b1;
	function [7:0] LedDec;
	input [3:0] num;
	begin
		case(num)
			4'h0: LedDec=8'b11000000;
			4'h1: LedDec=8'b11111001;
			4'h2: LedDec=8'b10100100;
			4'h3: LedDec=8'b10110000;
			4'h4: LedDec=8'b10011001;
			4'h5: LedDec=8'b10010010;
			4'h6: LedDec=8'b10000010;
			4'h7: LedDec=8'b11111000;
			4'h8: LedDec=8'b10000000;
			4'h9: LedDec=8'b10011000;
			4'ha: LedDec=8'b10001000;
			4'hb: LedDec=8'b10000011;
			4'hc: LedDec=8'b10100111;
			4'hd: LedDec=8'b10100001;
			4'he: LedDec=8'b10000110;
			4'hf: LedDec=8'b10001110;
			default: LedDec=8'b11111111;
		endcase
	end
	endfunction
		wire [7:0] tdat;
		assign tdat=LedDec(idat);
		assign odat={dot, tdat[6:0]};
endmodule
			
			
			
			