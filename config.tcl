set ::env(DESIGN_NAME) full_adder
set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/src/full_adder.v"
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "10"

# Floorplanning
set ::env(FP_CORE_UTIL) 20
set ::env(DIE_AREA) "0 0 200 200"
set ::env(CORE_AREA) "10 10 190 190"
set ::env(FP_ASPECT_RATIO) 1.0
set ::env(FP_CORE_MARGIN) 2

# Power Network
set ::env(FP_PDN_ENABLE) 1
set ::env(VDD_NETS) "vdd"
set ::env(GND_NETS) "gnd"

# Disable unnecessary optimizations for small logic
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(GLB_RESIZER_BUFFER_OUTPUT_PORTS) 0
set ::env(DIODE_INSERTION_STRATEGY) 0

# IO
set ::env(FP_IO_MODE) 1

# Save layout
set ::env(SAVE_FINAL_LAYOUT) 1
