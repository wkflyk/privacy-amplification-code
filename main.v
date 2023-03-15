module main(
clk,
rst_n,

zzmy
    );
    parameter N =128;
    
    input clk;
    input rst_n;
    output [N-1:0] zzmy;
    
    wire [13:0] rom_add;
    wire [N-1:0] rom_data;
    wire en1;
    wire en2;
    wire en3;
    wire en4;
    wire ite;
    wire [N-1:0] itesum;
    wire [N-1:0] ybzdj;
    
    wire [N-1:0] ybzdjout1;
    wire [N-1:0] ybzdjout2;
    wire [N-1:0] ybzdjout3;
    wire [N-1:0] ybzdjout4;
    wire [N-1:0] xsmyout1;
    wire [N-1:0] xsmyout2;
    wire [N-1:0] xsmyout3;
    wire [N-1:0] xsmyout4;
    wire caen1;
    wire caen2;
    wire caen3;
    wire caen4;
    wire [N-1:0] xsmyinca;
    wire [N-1:0] ybzdjinca;
    
    wire [N-1:0] caout;
    wire acen;
    
    blk_mem_gen_0 rom1(.clka(clk),
    .addra(rom_add),
    .douta(rom_data)
    );
    
    rom_control rom_control1(.clk(clk),
    .rst_n(rst_n),
    .data_add(rom_add),
    .en(en1)
    );
    
    ybzdj ybzdj1(.clk(clk),
    .rst_n(rst_n),
    .en(en2),
    .ite(ite),
    .itesum(itesum),
    .ybzdj(ybzdj)
    );
    
    read_write read_write1(.clk(clk),
    .rst_n(rst_n),
    .en(en1),
    .ybzdj_in(ybzdj),
    .xsmy_in(rom_data),
    .next_en(en2),
    .ca_en(caen1),
    .ybzdj_out(ybzdjout1),
    .xsmy_out(xsmyout1)
    );
    
    read_write read_write2(.clk(clk),
    .rst_n(rst_n),
    .en(en2),
    .ybzdj_in(ybzdj),
    .xsmy_in(rom_data),
    .next_en(en3),
    .ca_en(caen2),
    .ybzdj_out(ybzdjout2),
    .xsmy_out(xsmyout2)
    );
    
    read_write read_write3(.clk(clk),
    .rst_n(rst_n),
    .en(en3),
    .ybzdj_in(ybzdj),
    .xsmy_in(rom_data),
    .next_en(en4),
    .ca_en(caen3),
    .ybzdj_out(ybzdjout3),
    .xsmy_out(xsmyout3)
    );
    
    read_write read_write4(.clk(clk),
    .rst_n(rst_n),
    .en(en4),
    .ybzdj_in(ybzdj),
    .xsmy_in(rom_data),
    .ca_en(caen4),
    .ybzdj_out(ybzdjout4),
    .xsmy_out(xsmyout4)
    );
    
    four_one four_one1(
    .en1(caen1),
    .en2(caen2),
    .en3(caen3),
    .en4(caen4),
    .data_in1(xsmyout1),
    .data_in2(xsmyout2),
    .data_in3(xsmyout3),
    .data_in4(xsmyout4),
    .data_out(xsmyinca)
    );
    
    four_one four_one2(
    .en1(caen1),
    .en2(caen2),
    .en3(caen3),
    .en4(caen4),
    .data_in1(ybzdjout1),
    .data_in2(ybzdjout2),
    .data_in3(ybzdjout3),
    .data_in4(ybzdjout4),
    .data_out(ybzdjinca)
    );
    
    caculate caculate1(.clk(clk),
    .rst_n(rst_n),
    .xsmy(xsmyinca),
    .ybzdj(ybzdjinca),
    .ca_en(caen1||caen2||caen3||caen4),
    .caout(caout),
    .acen(acen)
    );
    
    accumulate accumulate1(.clk(clk),
    .rst_n(rst_n),
    .acen(acen),
    .cain(caout),
    .ite(ite),
    .itesum(itesum)
    );
    
    assign zzmy=itesum;
endmodule
