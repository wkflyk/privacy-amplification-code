module accumulate(
clk,
rst_n,
acen,
cain,
ite,
itesum
    );
  parameter N=128;     //协商密钥长度
  parameter C=10;       //分块数量
  
  input clk;         //时钟信号
  input rst_n;       //复位信号
  input  acen;      //累加使能
  input [N-1:0] cain;   //计算结果输入
  output reg ite=0;           //迭代信号
  output [N-1:0] itesum;        //迭代值
  

  reg [N-1:0] acount=0; //累加值
  reg [3:0] count=0;  //迭代计数

always@(posedge clk or negedge rst_n)
begin
   if(!rst_n)
     begin
        acount<=0;
        count<=0;
     end
   else
     begin
        if(acen)
          begin
             if(count==0)
               begin
                  acount<=0;
                  acount<=acount^cain;
                  count<=count+1;
                  ite<=0;
               end
             else if(count==C-1)
                begin
                   ite<=1;
                   acount<=acount^cain;
                   count<=0;
                end
             else
                begin
                   acount<=acount^cain;
                   count<=count+1;
                end  
          end
     end
     
end

assign itesum=acount;

endmodule
