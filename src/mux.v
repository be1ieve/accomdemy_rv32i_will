`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/04 19:26:42
// Design Name: 
// Module Name: mux4to1_32
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

module mux4to1_32(
    input [1:0] switch,
    input [31:0] input00,
    input [31:0] input01,
    input [31:0] input10,
    input [31:0] input11,
    output reg [31:0] out
    );
    
    always @(*) begin
        case(switch)
            2'b00: out = input00;
            2'b01: out = input01;
            2'b10: out = input10;
            2'b11: out = input11;
        endcase
        end
endmodule

module mux2to1_32(
    input switch,
    input [31:0] input0,
    input [31:0] input1,
    output reg [31:0] out
    );
    
    always @(*) begin
        if(switch) out = input1;
        else out = input0;
    end
endmodule