class low_sequencer  extends uvm_sequencer #(low_sequence_item);
    /*Factory registration for the sequencer*/
    `uvm_component_utils(low_sequencer)
    /*Construction of the class*/

    function new(string name = "low_sequencer",uvm_component parent = null);

        super.new(name,parent);
        
    endfunction //new()




endclass //low_sequencer extends superClass