module  top_dds
(
    input  wire         sys_clk   ,
	input  wire         sys_rst_n ,
	input  wire  [3:0]  key       ,
	
	output  wire  [7:0]  wave_out ,
	output  wire         dac_clk

);

wire  [3:0]  wave_select;

//时钟信号-传到DAC板卡时钟错位，便于在板卡在数据稳定时读取
assign  dac_clk = ~sys_clk;

//按键控制实例化
key_control  key_control_inst
(
    .sys_clk    (sys_clk),
	.sys_rst_n  (sys_rst_n),
	.key        (key),
  
    .wave_select(wave_select)	

);

//实例化dds
dds  dds_inst
(
    .sys_clk    (sys_clk),
	.sys_rst_n  (sys_rst_n),
	.wave_select(wave_select),
	
	.wave_out   (wave_out)

);








endmodule