import uvm_pkg::*;

class projectSequenceItem extends uvm_sequence_item;

    rand bit [2:0] priorityIn;
    rand bit [1:0] priorityOut;
    
    `uvm_object_utils_begin(projectSequenceItem)
        `uvm_field_int (priorityIn, UVM_DEFAULT)
        `uvm_field_int (priorityOut, UVM_DEFAULT)
    `uvm_object_utils_end
    
    function new (string name = "projectSequenceItem");
        super.new(name);
    endfunction
    
    virtual function string convert2string();
        return $sformatf("priorityIn = 0x%0h priorityOut = 0x%0h");
    endfunction
    
endclass: projectSequenceItem