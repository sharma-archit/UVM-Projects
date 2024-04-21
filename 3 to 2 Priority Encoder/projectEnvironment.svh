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