class projectSequence extends uvm_sequence#(projectSequenceItem);

    `uvm_object_utils(projectSequence)
    
    function new (string name = "");
        super.new(name);
    endfunction
    
    //Main body method that gets executed once sequence is started
    task body();
        
        projectSequenceItem projectTransaction;
        
        //Create 10 random transactions and send to driver
        repeat(8) begin
        
        projectTransaction = projectSequenceItem::type_id::create(.name("projectTransaction"), .contxt(get_full_name()));
        start_item(projectTransaciton);
        assert (projectTransaction);
        finish_item(projectTransaction);
        
        end
        
    endtask
    
endclass: projectSequence