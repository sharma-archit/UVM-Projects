class projectMonitor extends uvm_monitor;

    //Virtual interface
    virtual virtualIf vif;
    
    uvm_analysis_port#(projectSequenceItem) item_collected_port;
    
    //Placeholder to capture transaction information
    projectSequenceItem trans_collected;

    `uvm_component_utils(projectMonitor)
    
    //Constructor
    function new (string name, uvm_component parent);
    
        super.new(name, parent);
        trans_collected = new();
        item_collected_port = new("item_collected_port", this);
        
    endfunction
    
    //Build phase
    function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);
        
        projectAgent agent;
    
        if($cast(agent, get_parent()) && agent != null)
            vif = agent.vif;
        
        else if(!uvm_config_db#(virtual virtualIf)::get(this, "", "vif", vif))
            `uvm_fatal("NO_VIF", {"Virtual interface m ust be set for: ", get_full_name(), ".vif"});
        
    endfunction: build_phase
        
     //Run phase
     virtual task run_phase(uvm_phase phase);
     
        forever begin
        
            @(posedge vif.MONITOR.clk);
            trans_collected.pIn = vif.monitor_cb.pIn;
            trans_collected.pOut = vif.mointor_cb.pOut;
            
        end
        
     endtask: run_phase
    
endclass: projectMonitor