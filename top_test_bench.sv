import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "sequence_item.sv"
`include "low_sequence.sv"
`include "low_sequencer.sv"


`include "low_monitor.sv"
`include "low_driver.sv"


`include "low_agent.sv"
`include "low_scoreboard.sv"
`include "low_subscriber.sv"

`include "low_env.sv"
`include "low_test.sv"


module top_test_bench ();
/*clock generation*/
bit clk_testbench; 
logic reset_testbench;
always #5 clk_testbench = ~clk_testbench;

/*physical interface instansiation */
intf in1 ();

/*Driving the clock interface*/
assign in1.clk_interface = clk_testbench;


/*Dut instansiation and connecting physical interface to the DUT*/

memory DUT ( 


.clk(in1.clk_interface),
.rst_n(in1.rst_n_interface),
.en(in1.en_interface),
.wr(in1.wr_interface),
.addr(in1.addr_interface),
.data_in(in1.data_in_interface),
.data_out(in1.data_out_interface),
.valid_out(in1.valid_out_interface)

);

task task_init;

clk_testbench = 0;
/* in1.rst_n_interface = 0;
#5
in1.rst_n_interface = 1; */


endtask 


initial begin
    /*configuring the virtual interface in the test class*/
    task_init();
    uvm_config_db #(virtual intf ) ::set(null,"uvm_test_top","memory_vif",in1);
    run_test("low_test");

end






endmodule 
