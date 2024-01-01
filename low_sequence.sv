class low_sequence extends uvm_sequence #(low_sequence_item);

`uvm_object_utils(low_sequence)
low_sequence_item memory_sequence_item;

int i;

task pre_body;
// creating the transaction
memory_sequence_item = low_sequence_item::type_id::create("memory_sequence_item");

endtask 

/*sequence 1 to write in address 0 and address 1 then read from address 1 */
task body;
/*defining sequence for testing the memory */
    
/*write in address 0*/

    for (i=0;i<16;i=i+1)begin 

start_item(memory_sequence_item);


memory_sequence_item.randomize();
memory_sequence_item.en_item = 1;
memory_sequence_item.wr_item = 1;

finish_item(memory_sequence_item);

end 


    for (i=0;i<16;i=i+1)begin 

start_item(memory_sequence_item);


memory_sequence_item.randomize();
memory_sequence_item.en_item = 1;
memory_sequence_item.wr_item = 0;

finish_item(memory_sequence_item);

end 



endtask 


/*end of sequence */



endclass 