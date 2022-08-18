`timescale 1ns / 1ps

module alu(
    input [16:0] full_op,
    input [31:0] in_value1,
    input [31:0] in_value2,
    output reg [31:0] out_value
    );
    
    always @(*) begin
        out_value = 32'b0;
        case(full_op[6:0])
            7'b0110011, // rv32i r-type arithmetic
            7'b0010011: // rv32i i-type arithmetic
                case(full_op[9:7])
                    3'b000: // add, sub, addi
                        if(full_op[16:10]==7'b0000000) out_value = in_value1 + in_value2;
                        else if(full_op[6:0]==7'b0110011 && full_op[16:10]==7'b0100000) out_value = in_value1 - in_value2;
                    3'b001: // sll, slli
                        if(full_op[16:10]==7'b0000000) out_value = in_value1 << in_value2[4:0];
                    3'b010: //slt, slti
                        if(full_op[16:10]==7'b0000000) out_value = $signed(in_value1) < $signed(in_value2);
                    3'b011: //sltu, sltiu
                        if(full_op[16:10]==7'b0000000) out_value = in_value1 < in_value2;
                    3'b100: // xor, xori
                        if(full_op[16:10]==7'b0000000) out_value = in_value1 ^ in_value2;
                    3'b101: // srl, sra, srli, srai
                        if(full_op[16:10]==7'b0000000) out_value = in_value1 >> in_value2[4:0];
                        else if(full_op[16:10]==7'b0100000) out_value = $signed(in_value1) >>> in_value2[4:0];
                    3'b110: // or, ori
                        if(full_op[16:10]==7'b0000000) out_value = in_value1 | in_value2;
                    3'b111: // and, andi
                        if(full_op[16:10]==7'b0000000) out_value = in_value1 & in_value2;
                endcase
            7'b1101111, // rv32i j-type jal
            7'b1100111, // rv32i i-type jalr
            7'b0110111, // rv32i u-type lui
            7'b0010111, // rv32i u-type auipc
            7'b1100011: begin // rv32i b-type branch
                out_value = in_value1 + in_value2;
            end

            default:
                out_value = 32'hdeadbeef;
        endcase
    end
endmodule
