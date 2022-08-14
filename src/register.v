`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/30 19:45:58
// Design Name: 
// Module Name: register
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


module register(
    input rd_e,
    input [4:0] rd,
    input [31:0] rd_v,
    input rs1_e,
    input [4:0] rs1,
    input rs2_e,
    input [4:0] rs2,
    input clk,
    output reg [31:0] rs1_v,
    output reg [31:0] rs2_v 
    );
    
    
    reg [31:0] registers[31:0];

    initial begin
        for(integer idx=0;idx<32;idx=idx+1) begin
            registers[idx] = 32'b0;
        end
        //registers[0] = 1024'b0;
        rs1_v = 32'b0;
        rs2_v = 32'b0;
    end
    
    always @(posedge clk) begin
        if (rd_e && (rd != 5'b0)) begin
            registers[rd] <= rd_v;
        end
    end

    always @(*) begin
        if (rs1_e) rs1_v = registers[rs1];
        if (rs2_e) rs2_v = registers[rs2];
    end
endmodule
