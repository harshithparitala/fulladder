No problem, here's the content for your `README.md` file, formatted for a Git repository, with all conversational terms and citations removed.

```markdown
# 1-bit Full-Adder ASIC Design with OpenLane

This repository contains all the necessary files and documentation to perform the Register Transfer Level (RTL) to GDSII (Graphic Database System II) physical design flow for a 1-bit full adder using the OpenLane automated digital design flow.

A 1-bit full adder is a fundamental combinational logic circuit that computes the sum of two single-bit binary numbers (A, B) and a carry-in bit (Cin), producing a sum bit (Sum) and a carry-out bit (Cout).

## Project Structure

The project files are organized within the `OpenLane/designs/full_adder/` directory as follows:

```

OpenLane/designs/full\_adder/
├── config.json
├── pin\_order.cfg
├── src/
│   ├── full\_adder.v
│   └── full\_adder.sdc
├── simulation/
│   └── full\_adder\_tb.v
└── analysis/
└── export\_gds\_features.py

````

## Design Files Explained

### `src/full_adder.v` (RTL Design)

This is the Verilog code that describes the digital logic of the 1-bit full adder at the Register Transfer Level. It defines the module's inputs and outputs and the boolean equations for `Sum` and `Cout`.

```verilog
`default_nettype none
module full_adder (
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum,
    output wire Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (A & Cin);
endmodule
`default_nettype wire
````

### `src/full_adder.sdc` (Timing Constraints)

This is the Synopsys Design Constraints (SDC) file. For this combinational (clock-less) circuit, it is intentionally left empty. OpenLane expects an SDC file to be present, and an empty one correctly signals that no clock-related timing constraints are needed.

```
# Intentionally empty
# no clocks in a combinational circuit.
```

### `pin_order.cfg` (Pin Order Configuration)

This file specifies the desired placement order of the design's input/output (I/O) pins on the chip's perimeter. This ensures predictable I/O placement for subsequent physical integration.

```
#W
A
B
Cin
#E
Sum
Cout
```

  * `#W`: Places pins A, B, Cin on the West side.
  * `#E`: Places pins Sum, Cout on the East side.

### `config.json` (OpenLane Master Configuration)

This JSON file is the primary configuration for the entire OpenLane flow, controlling various parameters for tools and stages.

```json
{
  "DESIGN_NAME": "full_adder",
  "VERILOG_FILES": "dir::src/*.v",
  "CLOCK_TREE_SYNTH": false,
  "CLOCK_PORT": "",
  "PNR_SDC_FILE": "dir::src/full_adder.sdc",
  "SIGNOFF_SDC_FILE": "dir::src/full_adder.sdc",
  "FP_PDN_VOFFSET": 5,
  "FP_PDN_HOFFSET": 5,
  "FP_PDN_VWIDTH": 2,
  "FP_PDN_HWIDTH": 2,
  "FP_PDN_VPITCH": 8,  
  "FP_PDN_HPITCH": 8,  
  "FP_PDN_SKIPTRIM": true,
  "FP_PIN_ORDER_CFG": "dir::pin_order.cfg",
  "pdk::sky130*": {
    "FP_CORE_UTIL": 20
  },
  "pdk::gf180mcu*": {
    "FP_CORE_UTIL": 20,
    "PL_TARGET_DENSITY": 0.5
  }
}
```

  * `DESIGN_NAME`: Specifies the top-level module.
  * `VERILOG_FILES`: Points to the RTL source.
  * `CLOCK_TREE_SYNTH`: Disabled for combinational logic.
  * `PNR_SDC_FILE`, `SIGNOFF_SDC_FILE`: Paths to the SDC file.
  * `FP_PDN_*`: Power Distribution Network settings (offset, width, pitch for vertical/horizontal power rails). Values like 8 are examples to resolve common errors where default pitches are too small for PDK rules.
  * `FP_PIN_ORDER_CFG`: Path to the pin order file.
  * `FP_CORE_UTIL`: Target percentage of the core area to be filled by standard cells.

### `simulation/full_adder_tb.v` (Simulation Testbench)

This Verilog testbench is used to functionally verify the `full_adder.v` design by applying all possible input combinations and displaying the outputs.

```verilog
`timescale 1ns/1ps
module full_adder_tb;
  reg A, B, Cin;
  wire Sum, Cout;

  full_adder dut (.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));

  integer i;
  initial begin
    $dumpfile("full_adder_tb.vcd");
    $dumpvars(0, full_adder_tb);
    $display(" A B Cin | Sum Cout");
    for (i=0; i<8; i=i+1) begin
      {A, B, Cin} = i[2:0];
      #1;
      $display(" %b %b %b  %b %b", A, B, Cin, Sum, Cout);
    end
    $finish;
  end
endmodule
```

### `analysis/export_gds_features.py` (GDS Analysis Script)

This optional Python script extracts geometric features and density information from the generated GDSII file for post-design analysis or machine learning applications.

-----

## Running the OpenLane Flow: Step-by-Step Guide

Follow these steps to run the full RTL-to-GDSII flow in an interactive OpenLane session.

### 1\. Enter the OpenLane Container

Navigate to your OpenLane directory on your host machine and then use `make mount` to launch the Docker container.

```bash
cd /path/to/your/OpenLane/directory # e.g., /home/harshith/OpenLane
make mount
```

Once inside the container, the prompt will change (e.g., `OpenLane Container (1.1.1):/openlane%`).

Then, start the interactive Tcl shell within the container:

```tcl
./flow.tcl -interactive
```

The prompt will change to `%`. Load the OpenLane package:

```tcl
package require openlane
```

### 2\. Prepare the Design

**Command**: `prep -design full_adder`
**Purpose**: Sets up the design environment, loads configuration, and prepares PDK files for the current run.

-----

### 3\. Run Synthesis

**Stage**: RTL-to-Netlist Conversion
**Command**: `run_synthesis`
**Purpose**: Translates the `full_adder.v` RTL into a technology-mapped gate-level netlist using standard cells from the PDK.
**Key Log File**: `logs/synthesis/1-synthesis.log`
**Interpretation**: Check for successful parsing of Verilog, successful loading of standard cell libraries, and confirmation of cell mapping (e.g., "ABC RESULTS" showing the specific gates used). Warnings about combinational networks or skipped sequential/tri-state cells are normal for this design.

-----

### 4\. Run Static Timing Analysis (Post-Synthesis)

**Stage**: Timing Verification
**Command**: `run_sta`
**Purpose**: Performs timing analysis on the synthesized netlist without layout parasitics. For this combinational design, it primarily confirms design integrity and reports unconstrained paths.
**Key Log File**: `logs/synthesis/2-sta.log`
**Interpretation**: Look for "No paths found" and "worst slack INF" for clock paths (expected for combinational). Verify "max slew violations count: 0", "max fanout violations count: 0", and "max cap violations count: 0" to ensure basic electrical integrity. Warnings about unannotated drivers or unconstrained ports are normal at this stage.

-----

### 5\. Run Initial Floorplanning

**Stage**: Physical Layout Definition
**Command**: `run_floorplan`
**Purpose**: Defines the overall chip size (die area) and the usable area for standard cells (core area). It also lays out the initial standard cell rows.
**Key Log File**: `logs/floorplan/3-initial_fp.log`
**Interpretation**: Confirm core area calculation and row creation.

-----

### 6\. Run I/O Placement

**Stage**: I/O Pin Placement
**Command**: `run_io_placement`
**Purpose**: Places the external input/output pins of the design around the perimeter of the defined die area, respecting the order specified in `pin_order.cfg`.
**Key Log File**: `logs/floorplan/4-place_io.log`
**Interpretation**: Verify that all pins are processed and placed on the correct sides as per `pin_order.cfg`.

-----

### 7\. Generate Power Delivery Network (PDN)

**Stage**: Power Grid Insertion
**Command**: `gen_pdn`
**Purpose**: Inserts the power (VPWR) and ground (VGND) distribution grid into the design's core area, adhering to `config.json` settings.
**Key Log File**: `logs/floorplan/6-pdn.log`
**Interpretation**: Crucially, check for "All shapes on net VPWR are connected." and "All shapes on net VGND are connected." to confirm power grid integrity.

-----

### 8\. Run Global Placement

**Stage**: Cell Placement (Coarse)
**Command**: `run_placement`
**Purpose**: Roughly positions all the standard cells within the core area to minimize overall wire length and congestion, preparing for detailed placement.
**Key Log File**: `logs/placement/5-global.log`
**Interpretation**: Review core utilization, number of placed instances, and HPWL reduction. Warnings about "No slacks found" are normal for combinational designs. Confirm routability assessment.

-----

### 9\. Run Clock Tree Synthesis (CTS)

**Stage**: Clock Network Processing & Post-Placement Optimization
**Command**: `run_cts`
**Purpose**: For synchronous designs, this builds a balanced clock tree. For this combinational design, it primarily runs post-placement optimizations and includes a final legalization step. It also performs a post-CTS STA.
**Key Log File**: `logs/cts/7-cts.log`
**Interpretation**: Confirm "No clock nets have been found" warnings (expected). Look for successful legalization with minimal displacement and improved HPWL. Common warnings about `.lib` table templates are usually benign.

-----

### 10\. Run Global Routing

**Stage**: Interconnect Pathfinding (Coarse)
**Command**: `run_global_routing`
**Purpose**: Calculates the coarse paths for all connections (nets) between cells and pins across the chip, considering overall congestion.
**Key Log File**: `logs/routing/8-global_routing.log`
**Interpretation**: Check for congestion metrics and initial wirelength estimates.

-----

### 11\. Run Detailed Routing

**Stage**: Interconnect Pathfinding (Fine)
**Command**: `run_detailed_routing`
**Purpose**: Converts the global routes into precise physical wire segments and vias on specific metal layers, strictly adhering to all design rules (DRC).
**Key Log File**: `logs/routing/9-detailed_routing.log`
**Interpretation**: Crucially, verify that `Number of violations = 0` after optimization iterations. This confirms successful, DRC-clean routing.



## Viewing the Layout

After the flow completes, you can view the final GDSII layout using KLayout:

```bash
klayout designs/full_adder/runs/<YOUR_RUN_TIMESTAMP>/results/signoff/full_adder.gds
```

Replace `<YOUR_RUN_TIMESTAMP>` with the actual timestamp of your run (e.g., `RUN_2025.07.17_11.24.00`).

```
```
