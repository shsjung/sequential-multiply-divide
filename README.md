# Sequential Multiplier and Divider Modules

## File Structure

- `rtl/`
  - `seq_divide.sv`: Sequential divider
  - `seq_multiply.sv`: Sequential multiplier
  - `seq_top.sv`: Top module that instantiates both sequential divider and multiplier modules
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

## License

This project is distributed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## Contributions

Contributions are welcome! Please open an issue or submit a Pull Request if you'd like to contribute to this project.
