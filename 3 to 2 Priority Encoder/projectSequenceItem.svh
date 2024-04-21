class projectSequenceItem extends uvm_sequence_item;

    rand bit [2:0] priorityIn;
    rand bit [1:0] priorityOut;
    
    `uvm_object_utils(projectSequenceItem)
    
    function new (string name = "projectSequenceItem");
        super.new(name);
    endfunction
    
endclass: projectSequenceItem