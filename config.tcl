# Design-specific config
set ::env(DESIGN_NAME) full_adder

# Source files
set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/src/full_adder.v"

# Clock definition (though full adder may not need a clock, OpenLane expects one)
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "10.0"

# Synthesis
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

# Floorplan
set ::env(FP_CORE_UTIL) 70
set ::env(FP_ASPECT_RATIO) 1.0
set ::env(FP_CORE_MARGIN) 2
set ::env(PL_TARGET_DENSITY) 0.65

# For very small designs, fix DIE and CORE areas
set ::env(DIE_AREA) "0 0 50 50"
set ::env(CORE_AREA) "5 5 45 45"

# PDN (Power Delivery Network)
set ::env(FP_PDN_ENABLE) 1
set ::env(VDD_NETS) "vdd"
set ::env(GND_NETS) "gnd"

# Placement
set ::env(PL_RANDOM_GLB_PLACEMENT) 1
set ::env(PL_BASIC_PLACEMENT) 1

# Routing
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(GLB_RESIZER_BUFFER_OUTPUT_PORTS) 0

# Disable DIODE insertion for minimal design
set ::env(DIODE_INSERTION_STRATEGY) 0

# I/O settings
set ::env(FP_IO_MODE) 1
set ::env(FP_IO_VEXTEND) 2
set ::env(FP_IO_HEXTEND) 2

# To ensure OpenLane doesn't crash due to missing cells
set ::env(DESIGN_IS_CORE) 1

# Clock tree synthesis is not needed here
set ::env(CLOCK_TREE_SYNTH) 0

# Save placement for debug (optional)
set ::env(SAVE_FINAL_LAYOUT) 1
