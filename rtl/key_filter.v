module key_filter
#(
	parameter CNT_MAX = 20'd999_999
)
(
	input  wire  sys_clock ,
	input  wire  sys_rst_n ,
	input  wire  key_in ,
	
	output reg   key_flag
);

reg	[19:0]	cnt_20ms;

//cnt_20ms 20ms计数器
always@(posedge sys_clock or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt_20ms <= 1'b0;
	else if(key_in == 1'b1)
		cnt_20ms <= 1'b0;
	else if(cnt_20ms == CNT_MAX && key_in == 1'b0)
		cnt_20ms <= cnt_20ms;
	else
		cnt_20ms <= cnt_20ms + 1'b1;

//key 标志位flag
always@(posedge sys_clock or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		key_flag <= 1'b0;
	else if(cnt_20ms == CNT_MAX - 1'b1)
		key_flag <= 1'b1;
	else
		key_flag <= 1'b0;


endmodule