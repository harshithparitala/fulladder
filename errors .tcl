cat /openLANE_flow/designs/full_adder/runs/08-07_10-33/logs/floorplan/10-pdn.log | tail -n 30


magic -T $PDK_ROOT/sky130A/libs.tech/magic/sky130A.tech \
  lef read runs/full_adder/results/floorplan/merged.lef \
  def read runs/full_adder/results/floorplan/full_adder.floorplan.def &
