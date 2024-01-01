class low_monitor extends uvm_monitor;
        /*Monitor registration to create type_id for creation in build function in higher layer*/

        `uvm_component_utils(low_monitor);
        virtual intf monitor_interface;
        low_sequence_item s1; 
        uvm_analysis_port #(low_sequence_item) my_analysis_port;

        /*Class construction*/
    function new(string name = "low_monitor",uvm_component parent = null);
        
        /*passing arguments to the parent class to avoid compilation errors due to non default arguments*/
        super.new(name,parent);

    endfunction //new()

    function void build_phase (uvm_phase phase);
         $display("monitor");
        super.build_phase(phase);
        s1 = low_sequence_item::type_id::create("s1");
        my_analysis_port = new("my_analysis_port",this);
       if (!uvm_config_db #(virtual intf ) ::get (this,"","memory_vif",monitor_interface)) begin
        
        `uvm_fatal(get_full_name(),"Error!");
       end
       
     
       if (monitor_interface != null) begin
        
        $display("sucess of configuration of monitor");
        
       end else 

       begin

        $display("failure");

       end
        
    endfunction

    function void connect_phase(uvm_phase phase);
      
      super.connect_phase(phase);

    endfunction

    task run_phase (uvm_phase phase);

    forever 
        begin

        @(posedge monitor_interface.clk_interface); 

        

        s1.data_out_item <= monitor_interface.data_out_interface;
        s1.valid_out_item <= monitor_interface.valid_out_interface;
        s1.data_in_item <= monitor_interface.data_in_interface;
        s1.wr_item <= monitor_interface.wr_interface;
        s1.en_item <= monitor_interface.en_interface;
        s1.addr_item <= monitor_interface.addr_interface;

       #1 my_analysis_port.write(s1);

       

        end 

    endtask 


endclass //low_monitor extends superClass