class low_agent extends uvm_agent;
    /*Registration of the component to the factor */
    `uvm_component_utils(low_agent)
    low_driver my_driver;
    low_monitor my_monitor;
    low_sequencer my_sequencer;
    virtual intf intf_config;
 
    uvm_analysis_port #(low_sequence_item) my_analysis_port;
    /*Constructing the object*/
    function new(string name = "low_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    function void build_phase (uvm_phase phase);
         $display("agent");
        super.build_phase(phase);
        my_driver = low_driver::type_id::create("my_driver",this);
        my_monitor = low_monitor::type_id::create("my_monitor",this);
        my_sequencer = low_sequencer::type_id::create("my_sequencer",this);
      
        my_analysis_port = new("my_analysis_port",this);

       if (!uvm_config_db #(virtual intf ) ::get (this,"","memory_vif",intf_config)) begin
        
        `uvm_fatal(get_full_name(),"Error!");
       end
       
        uvm_config_db #(virtual intf ) ::set (this,"my_driver","memory_vif",intf_config);
        uvm_config_db #(virtual intf ) ::set (this,"my_monitor","memory_vif",intf_config);
    endfunction

    function void connect_phase(uvm_phase phase);
      
      super.connect_phase(phase);
       my_monitor.my_analysis_port.connect(my_analysis_port);
     //  my_driver.seq_item_Port.connect(my_sequencer.seq_item_export); 
  
        my_driver.seq_item_port.connect(my_sequencer.seq_item_export);  
    endfunction



endclass //low_agent extends superClass

