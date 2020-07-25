module m_font_rom(input [9:0] radr, output [9:0] dat);
	function [9:0] FontDec;
	input [9:0] dadr;
	begin
		case(dadr)
			10'd00: FontDec=10'h006;
			10'd01: FontDec=10'h382;
			10'd02: FontDec=10'h2bb;
			10'd03: FontDec=10'h2aa;
			10'd04: FontDec=10'h2ea;
			10'd05: FontDec=10'h2ab;
			10'd06: FontDec=10'h2aa;
			10'd07: FontDec=10'h2bb;
			10'd08: FontDec=10'h382;
			10'd09: FontDec=10'h006;
			10'd10: FontDec=10'h000;
			10'd11: FontDec=10'h082;
			10'd12: FontDec=10'h28a;
			10'd13: FontDec=10'h2ab;
			10'd14: FontDec=10'h1ae;
			10'd15: FontDec=10'h1ab;
			10'd16: FontDec=10'h3fa;
			10'd17: FontDec=10'h1ab;
			10'd18: FontDec=10'h1ab;
			10'd19: FontDec=10'h2ab;
			10'd20: FontDec=10'h28a;
			10'd21: FontDec=10'h082;
			10'd22: FontDec=10'h000;
			10'd23: FontDec=10'h07c;
			10'd24: FontDec=10'h044;
			10'd25: FontDec=10'h044;
			10'd26: FontDec=10'h044;
			10'd27: FontDec=10'h3ff;
			10'd28: FontDec=10'h044;
			10'd29: FontDec=10'h044;
			10'd30: FontDec=10'h044;
			10'd31: FontDec=10'h07c;
			default: FontDec=10'h000;
		endcase
	end
	endfunction
	assign dat = FontDec(radr);
endmodule


module m_character_disp(input clk, output [3:0] vga_r, output [3:0] vga_g, output [3:0] vga_b, output vga_hs, output vga_vs);
	reg [9:0] hs_cnt;
	reg [9:0] vs_cnt;
	reg vga_clk, i_vs, i_hs, i_hdisp, i_vdisp;
	wire pixdat;
	wire [9:0] vga_x;
	wire [9:0] vga_y;
	wire [0:9] fontdat;
	
	assign vga_hs=i_hs;
	assign vga_vs=i_vs;
	assign vga_r=(i_hdisp && i_vdisp && pixdat)? 4'hf: 4'd0;
	assign vga_g=(i_hdisp && i_vdisp && pixdat) ? 4'hf: 4'd0;
	assign vga_b=(i_hdisp && i_vdisp && pixdat)? 4'hf : 4'd0;
	
	always @(posedge clk) begin
		vga_clk=~vga_clk;
	end
	
	always @(posedge vga_clk) begin
		if(hs_cnt==10'd799)
			hs_cnt=10'd0;
		else
			hs_cnt=hs_cnt+1;
	end
	
	always @(posedge vga_clk) begin
		if(hs_cnt==10'd0)
			i_hs=1'b0;
		else if(hs_cnt==10'd96)
			i_hs=1'b1;
		else
			i_hs=i_hs;
	end
	
	always @(posedge vga_clk) begin
		if(hs_cnt==10'd144)
			i_hdisp=1'b1;
		else if (hs_cnt==10'd784)
			i_hdisp=1'b0;
		else
			i_hdisp=i_hdisp;
	end
	
	always @(posedge i_hs) begin
		if(vs_cnt==10'd520)
			vs_cnt=10'd0;
		else
			vs_cnt=vs_cnt+1;
	end
	
	always @(posedge i_hs) begin
		if(vs_cnt==10'd0)
			i_vs=1'b1;
		else if(vs_cnt==10'd2)
			i_vs=1'b1;
		else
			i_vs=i_vs;
	end
	
	always @(posedge i_hs) begin
		if(vs_cnt==10'd31)
			i_vdisp=1'b1;
		else if(hs_cnt==10'd511)
			i_vdisp=1'b0;
		else
			i_vdisp=i_vdisp;
	end
	
	
	assign vga_x=hs_cnt-10'd145;
	assign vga_y=vs_cnt-10'd32;
	
	m_font_rom fr(vga_y, fontdat);
	
	assign pixdat=((vga_x>=0)&&(vga_x<10)) ? fontdat[vga_x] : 1'b0;
	
endmodule
	
	
	
	