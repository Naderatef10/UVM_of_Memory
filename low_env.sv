class low_env extends uvm_env;
   
    `uvm_component_utils(low_env);

    function new(string name = "low_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    low_agent my_agent;
    low_scoreboard my_scoreboard;
    low_subscriber my_subscriber;
    
    virtual intf intf_config;


    function void build_phase (uvm_phase phase);
    //    $display("env");
        super.build_phase(phase);
        `uvm_info(get_type_name(), $sformatf("We are in enviroment build phase"), UVM_LOW) 
        /*Factory creation*/
        my_agent = low_agent::type_id::create("my_agent",this);
        my_scoreboard = low_scoreboard::type_id::create("my_scoreboard",this);
        my_subscriber = low_subscriber::type_id::create("my_subscriber",this);
        /*resource configruation*/

       if (!uvm_config_db #(virtual intf ) ::get (this,"","memory_vif",intf_config)) begin
        
        `uvm_fatal(get_full_name(),"Error!");
       end
       
        uvm_config_db #(virtual intf ) ::set (this,"my_agent","memory_vif",intf_config);


    endfunction

     function void end_of_elaboration_phase (input uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        $display("my_agent");
    endfunction

    function void start_of_simulation_phase (input uvm_phase phase);
        super.start_of_simulation_phase(phase);
        $display("my_agent");
    endfunction


    function void connect_phase(uvm_phase phase);
      
      super.connect_phase(phase);
      `uvm_info(get_type_name(), $sformatf("We are in enviroment connect phase"), UVM_LOW) 
      my_agent.my_analysis_port.connect(my_scoreboard.my_analysis_export);
      my_agent.my_analysis_port.connect(my_subscriber.my_analysis_export);
    endfunction


endclass //low_env extends superClass