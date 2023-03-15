module read_write(
clk,
rst_n,
ybzdj_in,
xsmy_in,
en,
next_en,
ca_en,
ybzdj_out,
xsmy_out
    );
  parameter N=128;     //协商密钥长度
  
  input clk;         //时钟信号
  input rst_n;       //复位信号
  input [N-1:0] xsmy_in;   //协商密钥输入
  input [N-1:0] ybzdj_in;   //元胞自动机输入
  input en;             //使能端
  output next_en;        //下个读取模块使能端
  output ca_en;           //计算模块使能端
  output [N-1:0] xsmy_out;   //协商密钥输出
  output [N-1:0] ybzdj_out;   //元胞自动机输出

  reg [N-1:0] ybzdj=0;
  reg [N-1:0] xsmy=0;
  reg nexten=0;
  reg caen=0;
  reg  [2:0] count=0; //周期计数器
 
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
       ybzdj<=0;
       xsmy<=0;
       nexten<=0;
       caen<=0;
       count<=0;
    end
  else
    begin
       if(en)
         begin
            if(count==3)
              begin
                 count<=0;
              end
            else if(count==0)
              begin
                 xsmy<=xsmy_in;
                 nexten<=1;
                 count<=count+1;
              end
            else if(count==1)
              begin
                 ybzdj<=ybzdj_in;
                 count<=count+1;
                 caen<=1;
              end
            else
              begin
                 caen<=0;
                 count<=count+1;
              end
           end
         else
           begin
              nexten<=0;
              caen<=0;
              xsmy<=0;
              ybzdj<=0;
           end
    end
end
  


assign xsmy_out=xsmy;
assign  ybzdj_out=ybzdj;
assign next_en=nexten;
assign ca_en=caen;


endmodule
