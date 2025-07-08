# Design name
set ::env(DESIGN_NAME) full_adder

# Source RTL
set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/src/full_adder.v"

# Clock (required even if unused)
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "10"

# Power nets
set ::env(VDD_NETS) "vdd"
set ::env(GND_NETS) "gnd"

# Floorplanning
set ::env(FP_CORE_UTIL) 30
set ::env(FP_ASPECT_RATIO) 1.0
set ::env(FP_CORE_MARGIN) 2
set ::env(DIE_AREA) "0 0 100 100"
set ::env(CORE_AREA) "10 10 90 90"

# PDN (enabled)
set ::env(FP_PDN_ENABLE) 1

# Optimizations disabled for simple gates
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(GLB_RESIZER_BUFFER_OUTPUT_PORTS) 0
set ::env(DIODE_INSERTION_STRATEGY) 0

# IO settings
set ::env(FP_IO_MODE) 1

# Save final layout
set ::env(SAVE_FINAL_LAYOUT) 1
