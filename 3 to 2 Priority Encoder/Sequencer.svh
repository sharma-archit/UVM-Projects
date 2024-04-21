class projectSequenceItem extends uvm_sequence_item;

    //Data
    rand bit [2:0] pIn;
    rand bit [1:0] pOut;

    //Utility and Field macros
    `uvm_object_utils_begin(projectSequenceItem)
        `uvm_field_int(pIn, UVM_ALL_ON)
        `uvm_field_int(pOut, UVM_ALL_ON)
    `uvm_object_utils_end

    //Constructor
    function new(string name = "projectSequenceItem");
        super.new(name);
    endfunction
    
endclass: projectSequenceItem

class projectSequencer extends uvm_sequencer#(projectSequenceItem);

    `uvm_component_utils(projectSequencer)
    
    //Constructor
    function new(string name = "projectSequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
    
endclass: projectSequencer

class projectSequence extends uvm_sequence#(projectSequenceItem);

    `uvm_sequence_utils(projectSequence, projectSequencer)
    
    //Constructor
    function new(string name = "projectSequence");
        super.new(name);
    endfunction
    
    virtual task body();
    
        req = projectSequenceItem::type_id::create("req");
        wait_for_grant();
        req.randomize();
        send_request(req);
        wait_for_item_done();
        
    endtask
    
endclass: projectSequence