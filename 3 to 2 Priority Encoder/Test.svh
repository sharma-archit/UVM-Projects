class projectTest extends uvm_test;

    `uvm_component_utils(projectTest)
    
    projectEnvironment env;
    projectSequence seq;
    
    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    //Build phase
    virtual function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);
    
        env = projectEnvironment::type_id::create("env", this);
        seq = projectSequence::type_id::create("seq", this);
        
    endfunction: build_phase
    
    //Run phase
    task run_phase(uvm_phase phase);
        
        phase.raise_objection(this);
            seq.start(env.agent.sequencer);
        phase.drop_objection(this);
        
    endtask: run_phase
    
endclass: projectTest