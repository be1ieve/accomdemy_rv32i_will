`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/04 22:13:43
// Design Name: 
// Module Name: instr_memory
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


module instr_memory(
    input [31:0] address,
    output reg [31:0] data
    );
    
    reg [7:0] memory [0:1023]; // 1024 bits = 256 instructions
    
    initial begin
        $readmemh("instructions.txt", memory); // location: project/project.sim/sim_1/xsim
        //{memory[32'h00],memory[32'h01],memory[32'h02],memory[32'h03]} = 32'h00000000; // deadbeef test value
        //{memory[32'h04],memory[32'h05],memory[32'h06],memory[32'h07]} = 32'h01400593; // addi a1 x0 20
        //{memory[32'h08],memory[32'h09],memory[32'h0a],memory[32'h0b]} = 32'h00300613; // addi a2 x0 3
        //{memory[32'h0c],memory[32'h0d],memory[32'h0e],memory[32'h0f]} = 32'h00c58533; // add a0 a1 a2
        //{memory[32'h10],memory[32'h11],memory[32'h12],memory[32'h13]} = 32'h0055b693; // sltiu a3 a1 5
        //{memory[32'h14],memory[32'h15],memory[32'h16],memory[32'h17]} = 32'h0325b713; // sltiu a4 a1 50
    end
    
    always @(*)begin
        data = {memory[address], memory[address+1], memory[address+2], memory[address+3]}; // For $readmemh()
        //data = {memory[address+3], memory[address+2], memory[address+1], memory[address]}; // For normal byte order
    end
    
endmodule
