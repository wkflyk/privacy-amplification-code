module rom_control(
clk,
rst_n,
data_add,
en
    );
  parameter N=128;     //协商密钥长度
  parameter max=10000; //rom深度
  
  input clk;         //时钟信号
  input rst_n;       //复位信号
  output reg [13:0] data_add; //rom地址选择
  output reg en;             //使能端


  
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
     begin
       data_add<=0;
       en<=0;
     end
   else
      begin
        if(data_add==14'd10000)
           begin
              en<=0;
           end
        else
           begin
              data_add<=data_add+1;
              en<=1;
           end
      end
end
  
endmodule
