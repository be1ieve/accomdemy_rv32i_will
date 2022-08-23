# accomdemy_rv32i

A workgroup implemention of simple RV32I simulation using verilog. The aim of this workgroup is to explain how the computer works and also to learn how to create a CPU by yourself. In this workgroup, we learn:
* The history of computer architecture.
* Verilog, the building blocks for creating a custom chip design.
* RISC-V, a new instruction set for building your own simple cpu.

And finally is this repository, An implemention of RV32I CPU design.

# Progress
## Stage 0
Firstly, we must understand the CPU structure, tools we will be using, and the goal we're reaching.
* Understand computer history and general PC architecture.
* Learning verilog from examples and online courses.
* Introduction to Vivado.
## Stage 1
In this stage we learn how to create modules using verilog. Here we use vivado as FPGA programming tool.
* Simple ALU with ADD, SUB, AND, OR, etc.
## Stage 2
In this stage we learn how RISC-V instructions are created and organized.
* Create RISC-V instruction decoder module.
* Rewrite previous ALU with RISC-V compatible opcodes.
## Stage 3
In this stage we learn how the modules are connected and link all modules to form a half-finished CPU.
* Finish register module.
* Combine decoder, register, and instruction modules.
## Stage 4
Now we build the front half of the CPU, which stores instructions and runs accordingly.
* Create an instruction memory module which stores instructions and be able to fetch from it.
* Create a program counter module 
## Stage 5
This time we're doing one of the most important part of our computer: JUMP and BRANCH. which enables subroutine process.
* Finish Program Counter module, with ability to branch and jump.

## Stage 5.5
This week I separate instruction memory module. Get ready for data memory.
* New testbench with cpu module and im module.
* Limit im address space to above 0x00010000, defined by RISC-V

# Community Links
For more information on this workgroup, see: [伴學松！！從0到有製作自己的CPU！！](https://hackmd.io/@accomdemy/BJprQ8Xjc/https%3A%2F%2Fhackmd.io%2F%40accomdemy%2FHJ-aO3JO9)<br/>
For community disscusions on Discord, See [riscv-cpu-伴學松](https://discord.com/channels/838422912507052062/980146541736128552)<br/>
For workgroup version of RV32I implementation, See: [accomdemy_rv32i](https://github.com/accomdemy/accomdemy_rv32i)<br/>
