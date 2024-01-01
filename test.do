vlog top_test_bench.sv
vlog memory.sv  
vsim -voptargs=+acc work.top_test_bench +cover
run -all
coverage report -codeAll -cvg -verbose

