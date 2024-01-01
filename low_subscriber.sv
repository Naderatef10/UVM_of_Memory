class low_subscriber extends uvm_subscriber #(low_sequence_item) ;

    `uvm_component_utils(low_subscriber)
    uvm_analysis_imp #(low_sequence_item,low_subscriber) my_analysis_export;
    low_sequence_item item_subscriber; 

    covergroup cov_inst();
/*       coverpoint item_subscriber.rst {
        bins bin_1 []={0,1};
        bins bin_2 =(0=>1); 
        bins bin_3 =(1=>0); 
      } */
      address_cover :coverpoint item_subscriber.addr_item {

          bins bin1 [] = {[0:15]}; 


      }
      data_out_cover :coverpoint item_subscriber.data_out_item;
      cross1 :cross item_subscriber.wr_item,item_subscriber.en_item;
      
    endgroup

    function void write(low_sequence_item t);

        item_subscriber = t;
        cov_inst.sample();
        
    endfunction

    function new(string name = "low_subscriber", uvm_component parent = null);

        super.new(name,parent);
        cov_inst = new();
    endfunction //new()

    function void build_phase (uvm_phase phase);
        item_subscriber = low_sequence_item::type_id::create("item_subscriber");  
        my_analysis_export = new("my_analysis_export",this);
        super.build_phase(phase);
        
    endfunction

    function void connect_phase(uvm_phase phase);
      
      super.connect_phase(phase);

    endfunction



  
  endclass //subscriber extends superClass