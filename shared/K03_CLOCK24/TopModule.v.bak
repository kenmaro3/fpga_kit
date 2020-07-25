module TopModule(
//	///CLOCK/////
//	input              CLK1,
//	input              CLK2,
//	//// SEG7/////
//	output     [7:0]   HEX0,
//	output     [7:0]   HEX1,
//	output     [7:0]   HEX2,
//	output     [7:0]   HEX3,
//	output     [7:0]   HEX4,
//	output     [7:0]   HEX5,
//	//// PUSH BUTTON //////
//	input      [1:0]   BTN,
//	///// LED////////
//	output     [9:0]   LED,
//	/////// SW///////////
//	input      [9:0]   SW

	input CLK1,
	input [1:0] BTN,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [9:0] LED
   
	);

	wire btn0 = BTN[0];
	wire clk = CLK1;
	wire clk1s;
	wire [7:0] w_sec;
	reg [25:0] cnt;
	wire en1hz = (cnt==26'd49999999);
	
	always @(posedge clk) begin
		if (btn0)
			cnt <= 26'b0;
		else if (en1hz)
			cnt <= 26'b0;
		else
			cnt <= cnt+ 26'b1;
	end
	
	
//	reg [3:0] sec;
//	always @(posedge clk) begin
//		if(btn0)
//			sec <= 4'h0;
//		else if (en1hz)
//			if(sec==4'h9)
//				sec <= 4'h0;
//			else
//				sec <= sec + 4'h1;
//	end
	
	
m_1s_clk clk0(clk, clk1s);
m_two_digits_clock(clk1s, w_sec);
m_seven_dec sd1(w_sec[3:0], HEX0);
m_seven_dec sd2(w_sec[7:4], HEX1);
assign LED = {5'b0, w_sec[3:0]};

endmodule


module m_1s_clk(input clk, output clk1s);
	reg [24:0] cnt;
	reg r1s;
	wire wcout;
	
	assign wcout=(cnt==25'd24999999) ? 1'b1 : 1'b0;
	assign clk1s = r1s;
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
		
		

module m_two_digits_clock(
	 input clk,
	 output [7:0] sec
	);
	
	wire [1:0] w_cb; //carry and borrow
	
	m_up_counter #(9)(clk, 1'b1, w_cb[0], sec[3:0]);
	m_up_counter #(5)(clk, w_cb[0], w_cb[1], sec[7:4]);

endmodule

module m_up_counter(input clk, input cb_in, output cb_out, output [3:0] cnt_out);
	parameter maxcnt = 9;
	reg [3:0] cnt;
	assign cnt_out = cnt;
	wire w_cout;
	
	assign cb_out = w_cout;
	assign w_cout=((cnt==maxcnt) && (cb_in==1'b1)) ? 1'b1 : 1'b0;
	
	always @(posedge clk) begin
		if(cb_in==1'b1) begin
			if(cnt==maxcnt)
				cnt=0;
			else
				cnt=cnt+1;
		end
	end

endmodule
	
	
	


module m_seven_dec(input [3:0] idat, output [6:0] odat);
//	wire sec = idat;
	reg [6:0] w_odat;
	
	always @* begin
		case (idat)
			4'h0: w_odat = 7'b1000000;
			4'h1: w_odat = 7'b1111001;
			4'h2: w_odat = 7'b0100100;
			4'h3: w_odat = 7'b0110000;
			4'h4: w_odat = 7'b0011001;
			4'h5: w_odat = 7'b0010010;
			4'h6: w_odat = 7'b0000010;
			4'h7: w_odat = 7'b1011000;
			4'h8: w_odat = 7'b0000000;
			4'h9: w_odat = 7'b0010000;
	//		4'ha: HEX0 = 7'b0001000;
	//		4'hb: HEX0 = 7'b0000011;
	//		4'hc: HEX0 = 7'b1000110;
	//		4'hd: HEX0 = 7'b0100001;
	//		4'he: HEX0 = 7'b0000110;
	//		4'hf: HEX0 = 7'b0001110;
			default: w_odat = 7'bxxxxxxx;
		endcase
	end
	
	assign odat = w_odat;


endmodule