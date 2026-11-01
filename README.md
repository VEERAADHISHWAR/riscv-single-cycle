# Single-Cycle RISC-V Processor (SystemVerilog)

A 32-bit single-cycle RISC-V processor implemented using SystemVerilog and developed with AMD Xilinx Vivado.

This project focuses on understanding processor architecture, including instruction fetch, decode, execution, memory access, and write-back.

## Project Structure

| Folder | Description |
|---|---|
| rtl/ | SystemVerilog processor design modules |
| tb/ | Module-level testbenches |
| docs/ | Waveform screenshots and documentation |

## Design Modules

| Module | Description |
|---|---|
| ALU | Arithmetic and logical operations |
| Register File | 32 general-purpose registers with two read ports and one write port |
| Program Counter | Stores the current instruction address |
| Instruction Memory | Stores processor instructions |
| Data Memory | Stores and retrieves data |
| Immediate Generator | Generates immediate values from instructions |
| Control Unit | Generates processor control signals |
| MUX | Selects between datapath inputs |
| Adder | Performs address calculations |
| RISC-V Top | Connects the processor components |

## Instruction Set

The processor implements a subset of the RV32I instruction set.

Update this section as instructions are implemented and verified.

## Tools Used

- SystemVerilog
- AMD Xilinx Vivado
- XSim Simulator
- Git
- GitHub

## Verification

Individual modules are verified using separate SystemVerilog testbenches.

A processor-level testbench will be used to verify complete instruction execution.

## Future Improvements

- Expand RV32I instruction support.
- Implement a five-stage pipelined processor.
- Add forwarding and hazard detection.
- Explore the RISC-V M extension.