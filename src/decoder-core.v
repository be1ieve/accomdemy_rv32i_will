`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/28 20:32:36
// Design Name: 
// Module Name: decoder-core
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


module decoder_core(
    input [31:0] inst,
    output reg rd_e,
    output reg [4:0] rd,
    output reg rs1_e,
    output reg [4:0] rs1,
    output reg rs2_e,
    output reg [4:0] rs2,
    output reg imm_e, // switch between rs2_v and imm for alu
    output reg [31:0] imm,
    output reg pc_e, // switch between rs1_v and pc for alu
    output reg jump_e, // jump control for pc
    output reg [16:0] full_inst // func7+func3+opcode
    );
    
    initial begin
        rd_e = 1'b0; rs1_e = 1'b0; rs2_e = 1'b0;
        rd = 5'b0; rs1 = 5'b0; rs2 = 5'b0;
        imm_e = 1'b0; imm = 32'b0; pc_e = 1'b0; full_inst = 17'b0;
    end
    
    always @(*) begin
        case(inst[6:0])
            7'b0110011: begin // R-type arithmetic
                full_inst = {inst[31:25], inst[14:12], inst[6:0]}; // func7 + func3 + opcode
                rd_e = 1;
                rd = inst[11:7];
                rs1_e = 1;
                rs1 = inst[19:15];
                rs2_e = 1;
                rs2 = inst[24:20];
                imm_e = 0;
                imm = 32'b0;
                pc_e = 0;
                jump_e = 0;
            end
            7'b0010011, // I-type arithmetic
            7'b0010011, // I-type load
            7'b1100111, // I-type jalr
            7'b1110011, // I-type ecall csr
            7'b0001111: begin // I-type fence
                full_inst = {7'b0, inst[14:12], inst[6:0]}; // 7'b0 + func3 + opcode
                rd_e = 1;
                rd = inst[11:7];
                rs1_e = 1;
                rs1 = inst[19:15];
                rs2_e = 0;
                rs2 = 5'b0;
                imm_e = 1;
                imm = {{20{inst[31]}}, inst[31:20]};
                pc_e = 0;
                jump_e = 0;
            end
            7'b0100011: begin // S-type Store
                full_inst = {7'b0, inst[14:12], inst[6:0]}; // 7'b0 + func3 + opcode
                rd_e = 0;
                rd = 5'b0;
                rs1_e = 1;
                rs1 = inst[19:15];
                rs2_e = 1;
                rs2 = inst[24:20];
                imm_e = 1;
                imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
                pc_e = 0;
                jump_e = 0;
            end
            7'b1100011: begin // B-type Store
                full_inst = {7'b0, inst[14:12], inst[6:0]}; // 7'b0 + func3 + opcode
                rd_e = 0;
                rd = 5'b0;
                rs1_e = 1;
                rs1 = inst[19:15];
                rs2_e = 1;
                rs2 = inst[24:20];
                imm_e = 1;
                imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
                pc_e = 1;
                jump_e = 0;
            end
            7'b0110111, //U-type lui
            7'b0010111 : begin // U-type auipc
                full_inst = {10'b0, inst[6:0]}; // 10'b0 + opcode
                rd_e = 1;
                rd = inst[11:7];
                rs1_e = 0;
                rs1 = 5'b0;
                rs2_e = 0;
                rs2 = 5'b0;
                imm_e = 1;
                imm = {inst[31:12], 12'b0};
                pc_e = 1; // required by auipc, not used by lui
                jump_e = 0;
            end
            7'b1101111: begin // J-type jal
                full_inst = {10'b0, inst[6:0]}; // 10'b0 + opcode
                rd_e = 1;
                rd = inst[11:7];
                rs1_e = 0;
                rs1 = 5'b0;
                rs2_e = 0;
                rs2 = 5'b0;
                imm_e = 1;
                imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
                pc_e = 1;
                jump_e = 1;
            end
            default: begin // all zero
                full_inst = 32'b0;
                rd_e = 0;
                rd = 5'b0;
                rs1_e = 0;
                rs1 = 5'b0;
                rs2_e = 0;
                rs2 = 5'b0;
                imm_e = 0;
                imm = 32'b0;
                pc_e = 0;
                jump_e = 0;
            end
        endcase
    end
endmodule
