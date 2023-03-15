module caculate(
clk,
rst_n,
xsmy,
ybzdj,
ca_en,
caout,
acen
    );
  parameter N=128;     //协商密钥长度
  
  input clk;         //时钟信号
  input rst_n;       //复位信号
  input [N-1:0] xsmy;   //协商密钥输入
  input [N-1:0] ybzdj;   //元胞自动机输入
  input  ca_en;     //使能
  output acen;             //累加器使能端
  output reg [N-1:0] caout=0;   //计算结果输出

  reg acen=0;

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
       acen<=0;
       caout<=0;
    end
  else
    begin
       if(ca_en)
         begin
            caout<=xsmy&ybzdj;
            acen<=1;
         end
    end
     
end
 


endmodule
