interface intf #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter DEPTH      = 16
);
 
 logic                   clk_interface;
 logic                   rst_n_interface;
 logic                   en_interface;
 logic                   wr_interface;
 logic  [ADDR_WIDTH-1:0] addr_interface;
 logic  [DATA_WIDTH-1:0] data_in_interface;
 logic  [DATA_WIDTH-1:0] data_out_interface;
 logic                   valid_out_interface;




    
endinterface //intf