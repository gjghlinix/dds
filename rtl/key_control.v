module  key_control(
    input    wire         sys_clk,
	input    wire         sys_rst_n,
	input    wire  [3:0]  key,

    output   reg   [3:0]  wave_select	

);
parameter    SIN_WAVE = 4'b0001,//正弦
             SQU_WAVE = 4'b0010,//方波
			 TRI_WAVE = 4'b0100,//三角波
			 SAW_WAVE = 4'b1000;//锯齿波

parameter    CNT_MAX = 20'd999_999;

wire   key0;
wire   key1;
wire   key2;
wire   key3;

//波形与按键状态对应起来
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        wave_select <= 4'd0;
	else if(key0 == 1'b1)
	    wave_select <= SIN_WAVE;
	else if(key1 == 1'b1)
	    wave_select <= SQU_WAVE;
	else if(key2 == 1'b1)
	    wave_select <= TRI_WAVE;
	else if(key3 == 1'b1)
	    wave_select <= SAW_WAVE;
	else
	    wave_select <= wave_select;
		
//按键实例化

key_filter
#(
	.CNT_MAX (CNT_MAX)
)
key0_inst
(
	.sys_clock (sys_clk),
	.sys_rst_n (sys_rst_n),
	.key_in    (key[0]),
	
	.key_flag  (key0)
);

key_filter
#(
	.CNT_MAX (CNT_MAX)
)
key1_inst
(
	.sys_clock (sys_clk),
	.sys_rst_n (sys_rst_n),
	.key_in    (key[1]),
	
	.key_flag  (key1)
);

key_filter
#(
	.CNT_MAX (CNT_MAX)
)
key2_inst
(
	.sys_clock (sys_clk),
	.sys_rst_n (sys_rst_n),
	.key_in    (key[2]),
	
	.key_flag  (key2)
);

key_filter
#(
	.CNT_MAX (CNT_MAX)
)
key3_inst
(
	.sys_clock (sys_clk),
	.sys_rst_n (sys_rst_n),
	.key_in    (key[3]),
	
	.key_flag  (key3)
);

endmodule