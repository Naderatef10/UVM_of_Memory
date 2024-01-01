class low_test extends uvm_test;
    `uvm_component_utils(low_test);

    low_env env;
    low_sequence seq1;
    virtual intf intf_config;
    virtual intf intf_local;

    function new(string name = "low_test",uvm_component parent = null);

        super.new(name,parent);
    endfunction //new()

    function void build_phase (uvm_phase phase);
            
        super.build_phase(phase);
        /*creation step*/
        `uvm_info(get_type_name(), $sformatf("We are in test build phase"), UVM_LOW) 
        env = low_env::type_id::create("env",this);
        seq1 = low_sequence::type_id::create("seq1");
        /*resource configuration passing the virtual interface*/ 
   
       if (!uvm_config_db #(virtual intf ) ::get (this,"","memory_vif",intf_config)) begin
        
        `uvm_fatal(get_full_name(),"Error!");
       end
        intf_local = intf_config;
        uvm_config_db #(virtual intf ) ::set (this,"env","memory_vif",intf_local);

        factory.print();
        
    endfunction

    function void connect_phase(uvm_phase phase);
      
      super.connect_phase(phase);
      `uvm_info(get_type_name(), $sformatf("We are in test connect phase"), UVM_LOW) 
    endfunction

 task run_phase (uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info(get_type_name(), $sformatf("We are in test run phase"), UVM_LOW)
        seq1.start(env.my_agent.my_sequencer);
        phase.drop_objection(this);



    endtask 

     function void end_of_elaboration_phase (input uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        $display("my_agent");
    endfunction

    function void start_of_simulation_phase (input uvm_phase phase);
        super.start_of_simulation_phase(phase);
        $display("my_agent");
    endfunction




endclass //low_test extends superClass