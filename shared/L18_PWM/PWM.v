module m_pwm(input clk, input [7:0] value, output pwm);
	reg[7:0] cnt;
	always @(posedge clk)
		cnt=cnt+1;
	assign pwm=(cnt<value)?1'b1 : 1'b0;
endmodule

//updown counter
module m_up_down_counter2(input clk, input up, input down, output [7:0] cnt_out);
	reg [7:0] cnt;
	
	assign cnt_out=cnt;
	always @(posedge clk) begin
		//up
		if((up==1'b1)&&(down==1'b0)) begin
			if(cnt<8'hff)
				cnt=cnt+1;
			end
			else if((up==1'b0)&&(down==1'b1)) begin
				if(cnt>0)
					cnt=cnt-1;
			end
		end
endmodule

// 1/100 sec clock generate
module m_10ms_clk(input clk, output clk10ms);
	reg[19:0] cnt;
	reg r10ms;
	wire wcout;
	
	assign wcout=(cnt==20'd249999)? 1'b1: 1'b0;
	assign clk10ms=r10ms;
	always @(posedge clk) begin
		if(wcout==1'b1) begin
			cnt=0;
			r10ms=~r10ms;
		end
		else begin
			cnt=cnt+1;
		end
	end
	
endmodule






// removing chattering
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