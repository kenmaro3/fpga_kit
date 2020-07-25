module m_color_bar(input clk, output [3:0] red, output [3:0] green, output [3:0] blue,
output v_sync, output h_sync);
	reg [9:0] hs_cnt;
	reg [9:0] vs_cnt;
	reg vga_clk, i_vs, i_hs, i_hdisp, i_vdisp;
	wire [2:0] RGB;
	
	//output signal
	assign h_sync=i_hs;
	assign v_sync=i_vs;
	assign red=(i_hdisp && i_vdisp && RGB[0]) ? 4'hf : 4'd0;
	assign green =(i_hdisp && i_vdisp && RGB[1]) ? 4'hf : 4'd0;
	assign blue = (i_hdisp && i_vdisp && RGB[2])? 4'hf : 4'd0;
	
	//vga clock
	always @(posedge clk) begin
		vga_clk=~vga_clk;
	end
	
	//hs_counter
	always @(posedge vga_clk) begin
		if(hs_cnt==10'd799)
			hs_cnt=10'd0;
		else
			hs_cnt=hs_cnt+1;
	end
	
	//h-sync
	always @(posedge vga_clk) begin
		if(hs_cnt==10'd144) 
			i_hdisp=1'b1;
		else if(hs_cnt==10'd784)
			i_hdisp=1'b0;
		else
			i_hdisp=i_hdisp;
	end
	
	//vs_counter
	always @(posedge i_hs) begin
		if(vs_cnt==10'd520)
			vs_cnt=10'd0;
		else
			vs_cnt=vs_cnt+1;
	end
	
	//v-sync
	always @(posedge i_hs) begin
		if(vs_cnt==10'd0) 
			i_vs=1'b0;
		else if (vs_cnt==10'd2)
			i_vs=1'b1;
		else
			i_vs=i_vs;
			
	end
	
	
	//v-disp
	always @(posedge i_hs) begin
		if(vs_cnt==10'd31)
			i_vdisp=1'b1;
		else if (hs_cnt==10'd511)
			i_vdisp=1'b0;
		else
			i_vdisp=i_vdisp;
	end
	
	//RGB
	assign RGB=(hs_cnt<10'd224) ? 3'd0:
		(hs_cnt<10'd304) ? 3'd1 :
		(hs_cnt<10'd384) ? 3'd2 :
		(hs_cnt<10'd464) ? 3'd3 :
		(hs_cnt<10'd544) ? 3'd4 :
		(hs_cnt<10'd624) ? 3'd5 :
		(hs_cnt<10'd704) ? 3'd6 : 3'd7;
		
endmodule
			
	
	
	
	