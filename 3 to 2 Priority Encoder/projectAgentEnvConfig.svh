`include "projectSequencer.svh"
`include "projectDriverSeqMon.svh"
`include "projectSequenceItem.svh"

class projectAgent extends uvm_agent;

    projectSequencer sqr;
    projectDriver drv;
    projectMonitor mon;
    
    virtual projectInterface vif;
    
    `uvm_component_utils_begin(projectAgent)
    `uvm_field_object(sqr, UVM_ALL_ON)
    `uvm_field_object(drv, UVM_ALL_ON)
    `uvm_field_object(mon, UVM_ALL_ON)
    `uvm_component_utils_end
    
    function new (string name, uvm_component parent = null)
        super.new(name, parent);
    endfunction
    
    //Build phase
    virtual function void build_phase(uvm_phase phase);
        
        sqr = projectSequencer::type_id::create("sqr", "vif", vif);
        drv = projectDriver::type_id::create("drv", "vif", vif);
        mon = projectMonitor::type_id::create("mon", "vif", vif);
        
        if (!uvm_config_db#(virtual projectInterface)::get(this, "", "vif", vif)) begin
        
            `uvm_fatal("NOVIF", "No virtual interface specified for this agent instance")
            
        end
        
        uvm_config_db#(virtual projectInterface)::set(this, "sqr", "vif", vif);
        uvm_config_db#(virtual projectInterface)::set(this, "drv", "vif", vif);
        uvm_config_db#(virtual projectInterface)::set(this, "mon", "vif", vif);
        
    endfunction: build_phase
    
    //Connect phase
    virtual function void connect_phase(uvm_phase phase);
    
        drv.seq_item_port.connect(sqr.seq_item_export);
        uvm_report_info("projectAgent::", "connect_phase, Connected driver to sequencer");
        
    endfunction: connect_phase
    
endclass: projectAgent

class projectEnvironment extends uvm_env;
    
    `uvm_component_utils(projectEnvironment);
    
    projectAgent agt;
    virtual projectInterface vif;
    
    function new (string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    //Build phase
    function void build_phase(uvm_phase phase);
        agt = projectAgent::type_id::create("agt", this);
        if (!uvm_config_db#(virtual projectInterface)::get(this, "", "vif", vif)) begin
        
            `uvm_fatal("NOVIF", "No virtual interface specified for this environment instance")
            
        end
        
        uvm_config_db#(virtual projectInterface)::set(this, "agt", "vif", vif);
        
    endfunction: build_phase
    
endclass: projectEnvironment

class projectConfig extends uvm_object;

    `uvm_object_utils(projectConfig)
    virtual projectInterface vif;
    
    function new (string name = "projectConfig");
        super.new(name);
    endfunction
    
endclass: projectConfig