`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/04 23:11:33
// Design Name: 
// Module Name: program_counter
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

// What this module do is only buffering program counter for each postive edge.
// Counting and jumping logic is done elsewhere.
module program_counter(
    input [31:0] pc_in,
    input rst,
    input clk,
    output reg [31:0] pc_out // instruction memory address is 32bit wide
    );

    initial begin
        pc_out = 32'b0;
    end

    always @(posedge clk) begin
        if(rst) pc_out = 32'b0;
        else pc_out <= pc_in;
    end
    
endmodule
