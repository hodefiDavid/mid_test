vlog -sv ALU_fixed.svp interface.sv 
vlog top.sv
vopt +acc top -o opt_test
vsim opt_test
run 0
