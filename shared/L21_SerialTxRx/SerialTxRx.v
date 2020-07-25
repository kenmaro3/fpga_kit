module m_clock9600(input clk, output sclk2x, output sclk);
	reg rclk2x;
	reg rclk;
	reg [11:0] cnt;
	
	always @(posedge clk) begin
		if(cnt==12'd1302) begin
			cnt=0;
			rclk2x=~rclk2x;
		end else begin
			cnt = cnt+1;
		end
		
	end
	
	always @(posedge rclk2x) begin
		rclk=~rclk;
	end
	assign sclk2x = rclk2x;
	assign sclk=rclk;
endmodule


module m_serial_tx(input sclk, input n_start, input [7:0] dat, output sout);
	reg[3:0] cnt;
	wire [10:0] tx_data;
	wire start, n_stop;
	assign ocnt = cnt;
	assign tx_data={1'b1, dat, 1'b0, 1'b1};
	assign n_stop=(cnt==4'd10) ? 1'b0 : 1'b1;
	
	m_rs_flipflop(n_start, n_stop, start);
	
	always @(posedge sclk or negedge start) begin
		if(start==1'b0) begin
			cnt = 0;
		end else begin
			if (cnt!=10)
				cnt=cnt+1;
		end
	end
	
	assign sout=tx_data[cnt];
	
endmodule


module m_serial_rx(input sclk2x, input sin, output [7:0] dat);
	reg [4:0] cnt;
	reg [7:0] sreg;
	always @(posedge sclk2x) begin
		if(cnt==5'h0) begin
			if(sin==1'b0)
				cnt=5'h1;
			end
			else begin
				if(cnt==5'd18)
					cnt=5'h0;
				else
					cnt=cnt+1;
			end
		end
		
		always @(posedge sclk2x) begin
			if(cnt[0]==1'b1)
				sreg={sin, sreg[7:1]};
		end
		assign dat=sreg;
endmodule

module m_chattering(input clk, input sw_in, output sw_out);
	reg [15:0] cnt;
	reg swreg;
	wire iclk;
	
	assign sw_out = swreg;
	
	always @(posedge clk) begin
		cnt = cnt+1;
	end
	assign iclk=cnt[15];
	
	always @(posedge iclk) begin
		swreg=sw_in;
	end
	
endmodule


module m_rs_flipflop(input set, input reset, output q);
	wire nq;
	assign q=~(set & nq);
	assign nq=~(reset & q);
endmodule



// 7 segment decoder
module m_seven_segment(input [3:0] idat, output [7:0] odat);
	parameter dot = 1'b1;
	function [7:0] LedDec;
		input [3:0] num;
		begin
			case (num)
				4'h0: LedDec = 8'b11000000; //0
				4'h1: LedDec = 8'b11111001; //1
				4'h2: LedDec = 8'b10100100; //2
				4'h3: LedDec = 8'b10110000; //3
				4'h4: LedDec = 8'b10011001; //4
				4'h5: LedDec = 8'b10010010; //5
				4'h6: LedDec = 8'b10000010; //6
				4'h7: LedDec = 8'b11111000; //7
				4'h8: LedDec = 8'b10000000; //8
				4'h9: LedDec = 8'b10011000; //9
				4'ha: LedDec = 8'b10001000; //a
				4'hb: LedDec = 8'b10000011; //b
				4'hc: LedDec = 8'b10100111; //c
				4'hd: LedDec = 8'b10100001; //d
				4'he: LedDec = 8'b10000110; //e
				4'hf: LedDec = 8'b10001110; //f
				default: LedDec = 8'b11111111; // led off by default
			endcase
		end
	endfunction
	wire [7:0] tdat;
	assign tdat= LedDec(idat);
	assign odat = {dot, tdat[6:0]};

endmodule









	
	
	
	
	
	