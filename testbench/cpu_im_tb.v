`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 20:43:52
// Design Name: 
// Module Name: cpu_mem_tb
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


module cpu_im_tb(

    );

    reg clk;
    reg reset_pc;

    wire [31:0] im_addr;
    wire [31:0] im_data;

    cpu _cpu(clk, reset_pc, im_data, im_addr);
    instr_memory _im(im_addr, im_data);

    initial begin // clock generator
        clk = 0; reset_pc = 1;
        #1 reset_pc = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    initial begin // timer
        #20 $stop;
    end


endmodule
