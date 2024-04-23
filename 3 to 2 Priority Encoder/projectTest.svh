`include "projectAgentEnvConfig.svh"
`include "projectSequence.svh"
`include "projectInterface.svh"

class projectTest extends uvm_test;
    
    `uvm_component_utils(projectTest);
    
    projectEnvironment env;
    projectConfig cfg;
    virtual projectInterface vif;
    
    function new (string name = "projectTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    //Build phase
    function void build_phase(uvm_phase phase);
        
        cfg = projectConfig::type_id::create("cfg", this);
        env = projectEnvironment::type_id::create("env", this);
        
        if (!uvm_config_db#(virtual projectInterface)::get(this, "", "vif", vif)) begin
        
            `uvm_fatal("NOVIF", "No virtual interface specified for this test instance");
        
        end
        
        uvm_config_db#(virtual projectInterface)::set(this, "env", "vif", vif);
        
    endfunction: build_phase
    
    //Run phase
    task run_phase(uvm_phase phase);
        
        projectSequence seq;
        seq = projectSequence::type_id::create("seq");
        phase.raise_objection(this, "Starting projectSequence main phase");
        $display("%t Starting sequence projectSequence run_phase", $time);
        seq.start(env.agt.sqr);
        #100ns;
        phase.drop_objection(this, "Finished seq in main phase");
        
    endtask: run_phase
    
endclass: projectTest