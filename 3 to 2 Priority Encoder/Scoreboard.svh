class projectScoreboard extends uvm_scoreboard;

    `uvm_component_utils(projectScoreboard)
    uvm_analysis_imp#(projectSequenceItem, projectScoreboard) item_collected_export;
    
    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    //Build phase
    function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);
        item_collected_export = new("item_collected_export", this);
    
    endfunction: build_phase;
    
    //Write
    virtual function void write(projectSequenceItem pkt);
        
        $display("SCB:: Pkt received");
        pkt.print();
        
    endfunction: write
    
    //Run phase
    virtual task run_phase(uvm_phase phase);
    
    endtask: run_phase
    
endclass: projectScoreboard