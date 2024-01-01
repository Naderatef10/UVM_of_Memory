class low_sequence_item  extends uvm_sequence_item;

`uvm_object_utils(low_sequence_item)

/*DUT IOS*/

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;

 logic en_item;
 logic wr_item;
randc logic [ADDR_WIDTH-1:0] addr_item;
randc logic [DATA_WIDTH-1:0] data_in_item;
logic [DATA_WIDTH-1:0] data_out_item;
logic valid_out_item;
logic rst_item;

constraint constr1{ addr_item  < 16;}



function new (string name = "low_sequence_item");
    
    super.new(name);

endfunction


endclass // extends superClass;