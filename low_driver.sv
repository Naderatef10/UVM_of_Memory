class low_driver extends uvm_driver #(low_sequence_item);

    /*Factor Registration */
    `uvm_component_utils(low_driver)
    virtual intf driver_interface;
    low_sequence_item sequence_item_inst;



    /*Construction*/
     function new(string name = "low_driver", uvm_component parent = null);
        
        super.new(name,parent);
        
     endfunction


    function void build_phase (uvm_phase phase);
        $display("driver");
        super.build_phase(phase);
        
       sequence_item_inst = low_sequence_item ::type_id::create("sequence_item_inst");

       if (!uvm_config_db #(virtual intf ) ::get (this,"","memory_vif",driver_interface)) begin
        
        `uvm_fatal(get_full_name(),"Error!");

       end
       
       if (driver_interface != null) begin
        
        $display("sucess of configuration of driver");
        
       end else 

       begin
        
        $display("failure");

       end
        
    endfunction

    function void connect_phase(uvm_phase phase);
      
      super.connect_phase(phase);

    endfunction

    task run_phase (uvm_phase phase) ;

      



      forever begin

        seq_item_port.get_next_item(sequence_item_inst);

      /*pin level conversion */
        @(posedge driver_interface.clk_interface)


        driver_interface.en_interface  <=  sequence_item_inst.en_item;

        driver_interface.wr_interface  <=  sequence_item_inst.wr_item;

        driver_interface.data_in_interface  <= sequence_item_inst.data_in_item;

        driver_interface.addr_interface  <= sequence_item_inst.addr_item;

        #1
        
         seq_item_port.item_done();

      end
      


    endtask 


endclass //low_driver extends superClass