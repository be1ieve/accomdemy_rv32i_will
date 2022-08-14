`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/04 19:31:05
// Design Name: 
// Module Name: define
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


// DATA STRUCTURE
`define REG_ADDR_LEN        [4:0]
`define REG_DATA_LEN        [31:0]
`define INSTRUCTION_LEN     [31:0]
`define RV32I_OPCODE_LEN    [6:0]
`define RV32I_FUNC3_LEN     [2:0]
`define RV32I_FUNC7_LEN     [6:0]
`define ALU_OP_LEN          [16:0]


// RV32I used opcodes
`define OP_OP_IMM           7'b0010011;
`define OP_OP               7'b0110011;
`define OP_LUI              7'b0110111;
`define OP_AUIPC            7'b0010111;
`define OP_JAL              7'b1101111;
`define OP_JALR             7'b1100111;
`define OP_BRANCH           7'b1100011;
`define OP_LOAD             7'b0000011;
`define OP_STORE            7'b0100011;
`define OP_MISC_MEM         7'b0001111;
`define OP_SYSTEM           7'b1110011;
