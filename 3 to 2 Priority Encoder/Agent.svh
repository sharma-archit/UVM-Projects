class projectAgent extends uvm_agent;
    
    //Declaring agent components
    projectDriver driver;
    projectSequencer sequencer;
    //projectMonitor monitor;
    
    `uvm_component_utils(projectAgent);
    
    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    //Build phase
    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);
        
        if(get_is_active() == UVM_ACTIVE) begin
        
            driver = projectDriver::type_id::create("driver", this);
            sequencer = projectSequencer::type_id::create("sequencer", this);
        
        end
        
        //monitor = projectMonitor::type_id::create("monitor", this);
        
    endfunction: build_phase
    
    //Connect phase
    function void connect_phase(uvm_phase phase);
    
        if(get_is_active() == UVM_ACTIVE) begin
    
            driver.seq_item_port.connect(sequencer.seq_item_export);
    
        end
    
    endfunction: connect_phase
        
endclass: projectAgent