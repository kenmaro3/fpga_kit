
module nios2pio_qsys (
	clk_clk,
	pio_0_external_connection_export,
	pio_1_external_connection_export,
	reset_reset_n);	

	input		clk_clk;
	output	[6:0]	pio_0_external_connection_export;
	input	[3:0]	pio_1_external_connection_export;
	input		reset_reset_n;
endmodule
