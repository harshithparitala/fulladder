# Design name
set ::env(DESIGN_NAME) "full_adder"

# RTL Verilog source
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/full_adder.v]

# Dummy clock definition (required by tools even for combinational logic)
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) 10.0

# Optional: If you create an SDC file later
# set ::env(SDC_FILE) "$::env(DESIGN_DIR)/src/base.sdc"

# Die area (adjust for your small design)
set ::env(DIE_AREA) "0 0 20 20"
set ::env(CORE_AREA) "2 2 18 18"

# Turn off I/O placement constraints (for simple designs)
set ::env(FP_IO_MODE) 1

# PDN grid (optional default)
set ::env(FP_PDN_CORE_RING) 1

# Set synthesis effort (optional)
set ::env(SYNTH_STRATEGY) "AREA 0"
