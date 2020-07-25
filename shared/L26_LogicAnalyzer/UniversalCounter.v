module m_universal_counter(input clk, input n_reset, input c_in, output c_out,
output [3:0] q);
    parameter maxcnt=15;
    reg [3:0] cnt;
    
    assign q=cnt;
    assign c_out=((cnt==maxcnt) && (c_in==1'b1)) ? 1'b1 : 1'b0;
    
    always @(posedge clk or negedge n_reset) begin
        if(n_reset==1'b0) begin
            cnt=4'h0;
        end
        else begin
            if(c_in==1'b1) begin
                if(cnt==maxcnt)
                    cnt=4'h0;
                else
                    cnt=cnt+1;
            end
        end
    end
endmodule


// removing chattering
module m_chattering(input clk, input sw_in, output sw_out);
    reg [15:0] cnt;
    reg swreg;
    wire iclk;

    assign sw_out = swreg;

    always @(posedge clk) begin
        cnt=cnt+1;
    end
    assign iclk=cnt[15];
    
    always @(posedge iclk) begin
        swreg=sw_in;
    end
endmodule


module m_seven_segment(input [3:0] idat, output [7:0] odat);

    function [7:0] LedDec;
        input [3:0] num;
        begin
            case (num)
            4'h0: LedDec = 8'b11000000;
            4'h1: LedDec = 8'b11111001;
            4'h2: LedDec = 8'b10100100;
            4'h3: LedDec = 8'b10110000;
            4'h4: LedDec = 8'b10011001;
            4'h5: LedDec = 8'b10010010;
            4'h6: LedDec = 8'b10000010;
            4'h7: LedDec = 8'b11111000;
            4'h8: LedDec = 8'b10000000;
            4'h9: LedDec = 8'b10011000;
            4'ha: LedDec = 8'b10001000;
            4'hb: LedDec = 8'b10000011;
            4'hc: LedDec = 8'b10100111;
            4'hd: LedDec = 8'b10100001;
            4'he: LedDec = 8'b10000110;
            4'hf: LedDec = 8'b10001110;
            default: LedDec = 8'b11111111;
        endcase
    end
    endfunction

    assign odat=LedDec(idat);
endmodule










        
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  