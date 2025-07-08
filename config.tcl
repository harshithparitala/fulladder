# Design Name
set ::env(DESIGN_NAME) full_adder

# RTL Source File
set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/src/full_adder.v"

# Dummy Clock (required by OpenLane flow)
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "10"

# Power/Ground Net Names (must match your RTL)
set ::env(VDD_NETS) "vdd"
set ::env(GND_NETS) "gnd"

# Floorplan Settings (tuned for small designs)
set ::env(FP_CORE_UTIL) 30
set ::env(FP_ASPECT_RATIO) 1.0
set ::env(FP_CORE_MARGIN) 2

# Fixed core/die area (for tiny RTL like full adder)
set ::env(DIE_AREA) "0 0 100 100"
set ::env(CORE_AREA) "10 10 90 90"

# Enable PDN Generation
set ::env(FP_PDN_ENABLE) 1

# Disable advanced steps not needed for this small design
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(GLB_RESIZER_BUFFER_OUTPUT_PORTS) 0
set ::env(DIODE_INSERTION_STRATEGY) 0

# I/O placement strategy
set ::env(FP_IO_MODE) 1

# Save GDS & DEF outputs
set ::env(SAVE_FINAL_LAYOUT) 1
