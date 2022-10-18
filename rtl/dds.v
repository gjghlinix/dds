module  dds(
    input  wire         sys_clk,
	input  wire         sys_rst_n,
	input  wire  [3:0]  wave_select,
	
	output  wire  [7:0]  wave_out

);

parameter    SIN_WAVE = 4'b0001,//正弦
             SQU_WAVE = 4'b0010,//方波
			 TRI_WAVE = 4'b0100,//三角波
			 SAW_WAVE = 4'b1000;//锯齿波

parameter    F_WORD = 32'd42929,//500Hz情况下公式算得的K值(频率控制字)
             P_WORD = 12'd1024;//相位控制字

reg    [31:0]   fre_add;
reg    [11:0]   rom_addr_reg;
reg    [13:0]   rom_addr;

//相位累加器赋值
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
	    fre_add <= 32'd0;
	else 
	    fre_add <= fre_add + F_WORD;
		
//rom地址寄存器
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
	    rom_addr_reg <= 12'd0;
	else 
	    rom_addr_reg <= fre_add[31:20] + P_WORD;//rom地址寄存器-相位累加的高12位
//ROM实际地址
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
	    rom_addr <= 14'd0;
	else 
	    case(wave_select)
		    SIN_WAVE:
			    rom_addr <= rom_addr_reg;
			SQU_WAVE:
			    rom_addr <= rom_addr_reg + 4096;
			TRI_WAVE:
			    rom_addr <= rom_addr_reg + 2*4096;
			SAW_WAVE:
			    rom_addr <= rom_addr_reg + 3*4096;
		    default:  rom_addr <= rom_addr_reg;
			
		endcase

wave	wave_inst 
(
	.address ( rom_addr ),
	.clock ( sys_clk ),
	.q ( wave_out )
	);


endmodule