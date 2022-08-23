`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/13 18:50:55
// Design Name: 
// Module Name: branch
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


module branch(
    input [9:0] branch_inst,
    input [31:0] rs1_v,
    input [31:0] rs2_v,
    output reg branch_e
    );
    
    always @(*) begin
        case(branch_inst[6:0])
            7'b1100011: begin // rv32i b-type branch
                case(branch_inst[9:7])
                    3'b000: // beq
                        branch_e = (rs1_v == rs2_v) ? 1 : 0;
                    3'b001: // bne
                        branch_e = (rs1_v == rs2_v) ? 0 : 1;
                    3'b100: // blt
                        branch_e = ($signed(rs1_v) < $signed(rs2_v)) ? 1 : 0;
                    3'b101: // bge
                        branch_e = ($signed(rs1_v) < $signed(rs2_v)) ? 0 : 1;
                    3'b110: // bltu
                        branch_e = (rs1_v < rs2_v) ? 1 : 0;
                    3'b111: // bgeu
                        branch_e = (rs1_v < rs2_v) ? 0 : 1;
                    default:
                        branch_e = 0;
                endcase
            end
            default:
                branch_e = 0;
        endcase
    end
endmodule
