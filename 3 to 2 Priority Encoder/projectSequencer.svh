class projectSequencer extends uvm_sequencer#(projectSequenceItem);

    `uvm_component_utils(projectSequencer)
    
    function new (input string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
endclass: projectSequencer