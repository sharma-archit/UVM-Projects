class projectMonitor extends uvm_monitor;

    virtual projectVirtualIf vif;
    
    //Analysis
    //Monitor writes transaction objects to this port once detected on interface
    uvm_analysis_port#(projectSequenceItem) ap;
    
    projectConfig cfg;
    
    `uvm_component_utils(projectMonitor)
    
    function new (string name, uvm_component parent = null);
        super.new("ap", this);
    endfunction
    
    //Build phase
    virtual function void build_phase(uvm_phase phase);
        
        projectAgent agent;
        
        if ($cast(agent, get_parent()) && agent != null) begin
        
            vif = agent.vif;
        
        end else if (!uvm_config_db#(virtual projectInterface)::get(this, "", "projectInterface", vif)) begin
        
            `uvm_fatal("NOVIF", "No virtual interface specifies for this monitor instance")
            
        end
        
     endfunction: build_phase
     
     //Run phase
     virtual task run_phase(uvm_phase phase);
        
        super.run_phase(phase);
        
        forever begin
        
            projectSequenceItem projectTransaction;
            
            do begin
            @(this.vif.monitor_cb);
            end
            
            projectTransaction = projectSequenceItem::type_id::create("projectTransaction", this);
            
            ap.write(projectTransaction);
        
        end
      
     endtask: run_phase
     
enclass: projectMonitor