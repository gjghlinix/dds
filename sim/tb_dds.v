`timescale 1ns/1ns
module   tb_dds();

reg    sys_clk;
reg    sys_rst_n;
reg  [3:0]  wave_select;

wire  [7:0]  wave_out;
//初始化输入参数
initial
    begin
	    sys_clk     <= 1'b1;
		wave_select <= 4'b0000;
		sys_rst_n   <= 1'b0;
		#200
		sys_rst_n   <= 1'b1;
		#10000
		wave_select <= 4'b0001;
		#8000000
		wave_select <= 4'b0010;
		#8000000
		wave_select <= 4'b0100;
		#8000000
		wave_select <= 4'b1000;
		#8000000
		wave_select <= 4'b0000;
	end

//产生时钟
always  #10 sys_clk = ~sys_clk;





dds  dds_inst
(
    .sys_clk     (sys_clk),
	.sys_rst_n   (sys_rst_n),
	.wave_select (wave_select),

	.wave_out    (wave_out)

);



endmodule