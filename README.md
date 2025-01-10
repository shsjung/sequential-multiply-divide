# Sequential Multiplier and Divider Modules

This project implements a sequential multiplier and divider using SystemVerilog. The sequential multiplier repeatedly shifts and adds partial products, while the sequential divider performs iterative subtraction and shifting to compute the quotient and remainder.

## File Structure

- `rtl/`
  - `seq_multiply.sv`: Sequential multiplier module
  - `seq_divide.sv`: Sequential divider module
  - `seq_top.sv`: Top module that instantiates both multiplier and divider modules
- `wavedrom/`: Waveform diagrams
- `obj_dir/`: Directory containing object files and executables generated during Verilator simulation
- `tb.cpp`: Testbench top-level file
- `Makefile`: Makefile script to run the testbench
- `README.md`: Project documentation
- `LICENSE`: License information

## Running the Testbench

The provided testbench is designed for simulation using Verilator. Ensure Verilator is installed before running the testbench. Refer to the [Verilator GitHub page](https://github.com/verilator/verilator) for installation instructions.

1. Clone this repository:

   ```bash
   git clone https://github.com/shsjung/sequential-multiply-divide.git
   ```

2. Navigate to the `sequential-multiply-divide` directory and run the following command:

   ```bash
   make
   ```

## Example Waveforms

Below are example waveforms of the sequential multiplier and the sequential divider.

1. Sequential Multiply

   ![Sequential Multiplier](https://svg.wavedrom.com/github/shsjung/sequential-multiply-divide/main/wavedrom/seq_multiplier_0.json)

   - The multiplier completes its operation in `WidthB`+1 clock cycles, which is 33 in this case.

2. Sequential Divide

   ![Sequential Divider](https://svg.wavedrom.com/github/shsjung/sequential-multiply-divide/main/wavedrom/seq_divider_0.json)

   - The divider completes its operation in `WidthB`+2 clock cycles, which is 34 in this case.

## License

This project is distributed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## Contributions

Contributions are welcome! Please open an issue or submit a Pull Request if you'd like to contribute to this project.
