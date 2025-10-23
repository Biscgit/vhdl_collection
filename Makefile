# -----------------------------
# General GHDL Makefile
# -----------------------------
GHDL      := ghdl
SRC_DIR   := src
TB_DIR    := testbenches
VHDL_EXT  := vhd

# List all design sources recursively
DESIGN_SRCS := $(shell find $(SRC_DIR) -type f -name '*.$(VHDL_EXT)')

# List all testbench files in testbenches folder
TB_SRCS := $(shell find $(TB_DIR) -type f -name '*.$(VHDL_EXT)')

# Extract testbench entity names (assume file name = entity)
TBS := $(basename $(notdir $(TB_SRCS)))

# Default target
all: run

# Analyze all design sources
analyze:
	@echo "Analyzing design sources..."
	$(GHDL) -a $(DESIGN_SRCS)
	@echo "Analyzing testbenches..."
	$(GHDL) -a $(TB_SRCS)

# Elaborate a specific testbench
elab: analyze
	@for tb in $(TBS); do \
		echo "Elaborating $$tb..."; \
		$(GHDL) -e $$tb; \
	done

# Run all testbenches
run: elab
	@for tb in $(TBS); do \
		echo "Running $$tb..."; \
		$(GHDL) -r $$tb; \
	done

# Run a specific testbench (pass TB=<entity_name>)
run_tb: analyze
	@if [ -z "$(TB)" ]; then \
		echo "Please provide TB=<testbench_entity>"; \
		exit 1; \
	fi
	$(GHDL) -e $(TB)
	$(GHDL) -r $(TB)

# Clean intermediate files
clean:
	@echo "Cleaning GHDL intermediate files..."
	rm -f *.o *.cf
	@echo "Don
