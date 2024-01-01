class low_scoreboard extends uvm_scoreboard; 

    `uvm_component_utils(low_scoreboard)
    uvm_tlm_analysis_fifo #(low_sequence_item) my_tlm_analysis_fifo ;
    uvm_analysis_export #(low_sequence_item) my_analysis_export;

    low_sequence_item sequence_item_1 ;

    //associative array to store address corresponding to the suitable randomized data
     // represents the memory 
       logic [31:0] golden_model [15:0];

     int queue_address [$]; 
 
    // we need to delay one clock cycle before the checker because the transaction has one clock cycle delay 
    // for data output valid to be asserted 
    
    int temp;

    function new(string name = "low_scoreboard",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    function void build_phase (uvm_phase phase);
        $display("scoreboard build phase");
        super.build_phase(phase);
        my_tlm_analysis_fifo = new("my_tlm_analysis_fifo",this);
        my_analysis_export = new ("my_analysis_export",this);
        
    endfunction

    function void connect_phase(uvm_phase phase);
      
      super.connect_phase(phase);
      my_analysis_export.connect(my_tlm_analysis_fifo.analysis_export);

    endfunction

    task run_phase (uvm_phase phase);

                forever 

                begin 
                    
                my_tlm_analysis_fifo.get_peek_export.get(sequence_item_1);
/*                  $display("******************** new sequence item *************************");
                $display("data output is :%d  ",sequence_item_1.data_out_item);
                $display("write_enable is :%d  ",sequence_item_1.wr_item);
                $display("data_in is :%d  ",sequence_item_1.data_in_item);
                $display("valid_out is :%d  ",sequence_item_1.valid_out_item);
                $display("addr_item is :%d  ",sequence_item_1.addr_item);
                $display("enable_memory is: %d",sequence_item_1.en_item);
                $display ("****************** new sequence item *****************************");  */

                    // write  
                if(sequence_item_1.en_item == 1 && sequence_item_1.wr_item == 1) begin
                            // writing in the golden model
                        golden_model[sequence_item_1.addr_item] = sequence_item_1.data_in_item;
                      /*   $display("data written in golden_model is :%d",sequence_item_1.data_in_item); */


                end 

                    // reading from the golden model and check if it is the same 
                else if (sequence_item_1.en_item == 1 && sequence_item_1.wr_item == 0) begin

                           queue_address.push_front(sequence_item_1.addr_item);     
                          
                          /*   $display("address pushed is: %d", sequence_item_1.addr_item); */

                        if(sequence_item_1.valid_out_item == 1) begin 
                            temp = queue_address.pop_back();
                     /*    $display ("address from queue is: %d" ,temp ) ; */
                       if ( golden_model[temp] == sequence_item_1.data_out_item ) 
                       begin 

                            $display ("sucessfull test");

                       end 

                       else begin
                        
                        $display ("failed test");
                        $display ("data from golden model is :%d",golden_model[temp]);
                        $display ("data from transaction is :%d",sequence_item_1.data_out_item);

                       end
                        end 
                end

                end 

    endtask 

endclass  