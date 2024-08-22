# Project name and output executable
PROJECT = alu_test
TOP_MODULE = tb_processor  # Top-level testbench module

# Source files (list all Verilog source files)
ALU_SRCS = ALU_test.v

# Compiler and options
IVERILOG = iverilog
VVP = vvp
WAVEFORM_VIEWER = gtkwave

# Output files
OUT = $(PROJECT).out
WAVEFORM = dump.vcd

# Default target: compile and run the simulation
all: $(OUT)
	@echo "Running simulation..."
	$(VVP) $(OUT)

# Compile Verilog files into an executable
$(OUT): $(ALU_SRCS)
	@echo "Compiling Verilog files..."
	$(IVERILOG) -o $(OUT) $(ALU_SRCS)

# View waveform using GTKWave
wave: $(WAVEFORM)
	@echo "Opening waveform..."
	$(WAVEFORM_VIEWER) $(WAVEFORM)

# Run the simulation and generate waveform
$(WAVEFORM): $(OUT)
	@echo "Running simulation and generating waveform..."
	$(VVP) $(OUT)

# Clean up generated files
clean:
	@echo "Cleaning up..."
	rm -f $(OUT) $(WAVEFORM)

# Phony targets (not real files)
.PHONY: all clean wave
