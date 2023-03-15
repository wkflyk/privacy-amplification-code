module  ybzdj(
clk,
rst_n,
en,
ite,
itesum,
ybzdj
    );
  parameter N=128;     //协商密钥长度
  
  input clk;         //时钟信号
  input rst_n;       //复位信号
  input ite;         //迭代信号 
  input en;    
  input [N-1:0] itesum;   //元胞自动机迭代值输入
  output reg [N-1:0] ybzdj=128'h123456789abcdef1123456789abcdef1;

  reg [N-1:0] ybzdj0=128'h123456789abcdef1123456789abcdef1;//赋初值


always@(posedge clk or negedge rst_n)
begin
   if(!rst_n)
     begin
        ybzdj0<=128'h123456789abcdef1123456789abcdef1;
     end
   else
     begin
        if(en)
          begin
             if(ite)
                begin
                   ybzdj0<=itesum;
                   ybzdj<=itesum;
                   ybzdj0<=ybzdj150(ybzdj0);
                end
              else
                begin
                   ybzdj<=ybzdj0;
                   ybzdj0<=ybzdj150(ybzdj0);
                end
          end
     end
end

function  rule150;
input [2:0]ybzdj;
integer i;
   begin
      case(ybzdj)
        3'b000:rule150=1;
        3'b001:rule150=0;
        3'b010:rule150=0;
        3'b011:rule150=1;
        3'b100:rule150=0;
        3'b101:rule150=1;
        3'b110:rule150=1;
        3'b111:rule150=0;
        default:;
      endcase
   end
endfunction


function [N-1:0] ybzdj150;
input [N-1:0]ybzdj;
integer i;
   begin
      ybzdj150[0]=rule150({ybzdj[1:0],ybzdj[N-1]});
      for(i=1;i<N-1;i=i+1)
         begin
            ybzdj150[i]=rule150({ybzdj[i+1],ybzdj[i],ybzdj[i-1]});
         end
      ybzdj150[N-1]=rule150({ybzdj[0],ybzdj[N-1:N-2]});
   end
endfunction


endmodule
