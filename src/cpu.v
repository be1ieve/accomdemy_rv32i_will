`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/05 21:23:24
// Design Name: 
// Module Name: cpu_pdra_tb
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


module cpu(
        input clk,
        input reset,
        input [31:0] op_code, // link from external im memory, it's always op_code.
        output reg [31:0] im_addr // link to external im memory
    );

    wire branch_e, jump_e;
    wire [31:0] pc_in, pc_out, next_pc;
    wire rd_e, rs1_e, rs2_e, imm_e, pc_e;
    wire [4:0] rd, rs1, rs2;
    wire [16:0] full_inst; // func7+func3+opcode
    wire [31:0] rd_v, rs1_v, rs2_v, imm;
    wire [31:0] value_1, value_2;
    wire [31:0] alu_out;

    mux2to1_32 _jumpsw(jump_e, next_pc, alu_out, pc_in); // input switch for pc
    adder_32 _pcadd(32'd4, pc_out, next_pc); // count next_pc, always +4 because no RV32C here.
    program_counter _pc(pc_in, reset, clk, pc_out); // hold output to sync with clk

    decoder_core _dc(op_code, rd_e, rd, rs1_e, rs1, rs2_e, rs2, imm_e, imm, pc_e, jump_e, full_inst);
    register _re(rd_e, rd, rd_v, rs1_e, rs1, rs2_e, rs2, clk, rs1_v, rs2_v);

    mux2to1_32 _pcsw(pc_e, rs1_v, pc_out, value_1); // for alu in_value1
    mux2to1_32 _immsw(imm_e, rs2_v, imm, value_2); // for alu in_value2

    alu _alu(full_inst, value_1, value_2, alu_out);
    branch _branch(full_inst[9:0], rs1_v, rs2_v, branch_e);

    mux4to1_32 _rdsw({1'b0, branch_e}, alu_out, next_pc, 32'b0, 32'b0, rd_v); // 00: alu_out, 01: next_pc, 10: memory_out, 11: invalid

    always @(posedge clk) begin
        im_addr <= pc_out;
    end

endmodule
