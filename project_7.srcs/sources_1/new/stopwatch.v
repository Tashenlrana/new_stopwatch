`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2025 01:38:29 PM
// Design Name: 
// Module Name: stopwatch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module stopwatch
(
input clock,
input reset,
output a,
output b,
output c,
output d,
output e,
output f,
output g,
output dp,
output [3:0] an
);


reg[3:0] first;
reg[3:0] second;

reg[22:0] delay;
wire test;

always@(posedge clock or posedge reset)
begin
if(reset)
delay <= 0;
else
delay<=delay +1;
end

assign test = &delay;

always@(posedge test or posedge reset)
begin
if (reset) begin
first<= 0;
second<=0;
end

else if (first == 4'd9) begin
first<= 0;
if (second == 4'd9)
second <=0;
else
second <= second+1;

end
else
first<= first+1;
end


//Multiplexing circuit below
localparam N =18;
reg [N-1:0] count;
always @ (posedge clock or posedge reset)
begin
if (reset)
count<=0;
else
count <= count+1;
end

reg[6:0] sseg;
reg [3:0] an_temp;
always@(*)
begin
case(count[N-1:N-2])

2'b00:
begin
sseg = first;
an_temp = 4'b1110;
end

2'b01:
begin
sseg = second;
an_temp =4'b1101;
end

2'b10:
begin
sseg = 6'ha;
an_temp =4'b1011;
end

2'b11:
begin
sseg =6'ha;
an_temp=4'b0111;
end
endcase
end
assign an =an_temp;

reg[6:0] sseg_temp;
always@(*)
begin
case(sseg)
 4'd0 : sseg_temp = 7'b1000000; //0
   4'd1 : sseg_temp = 7'b1111001; //1
   4'd2 : sseg_temp = 7'b0100100; //2
   4'd3 : sseg_temp = 7'b0110000; //3
   4'd4 : sseg_temp = 7'b0011001; //4
   4'd5 : sseg_temp = 7'b0010010; //5
   4'd6 : sseg_temp = 7'b0000010; //6
   4'd7 : sseg_temp = 7'b1111000; //7
   4'd8 : sseg_temp = 7'b0000000; //8
   4'd9 : sseg_temp = 7'b0010000; //9
   default : sseg_temp = 7'b0111111; //dash
  endcase
 end
assign {g, f, e, d, c, b, a} = sseg_temp; 
assign dp = 1'b1; //we dont need the decimal here so turn all of them off



endmodule





