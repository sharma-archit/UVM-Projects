class projectDriver extends uvm_driver#(projectSequenceItem);

    `uvm_component_utils(projectDriver)
    
    virtual projectInterface vif;
    projectConfig cfg;
    
    //Build phase
    function void build_phase(uvm_phase phase);
        
        projectAgent agent;
        
        super.build_phase(phase);
        
        if ($cast(agent, get_parent()) && agent != null) begin
            
            vif = agent.vif;
        
        end else if (!uvm_config_db#(virtual projectInterface)::get(this, "", "vif", vif)) begin
            
            `uvm_fatal("NOVIF", "No virtual interface specified for this driver instance")
            
        end
        
    endfunction: build_phase
    
    //Run phase
    virtual task run_phase(uvm_phase phase);
        
        super.run_phase(phase);
        
        forever begin
            
            projectSequenceItem tr;
            @(this.vif.projectCB);
            seq_item_port.get_next_item(tr);
            @(this.vif.projectCB);
            sequenceItem::pIn: driverWrite(tr.pIn);
            seq_item_port.item_done();
            
        end
        
    endtask: run_phase
    
    //Driver write
    virtual protected task driverWrite(input bit pIn, output bit pOut);
        
        this.vif.projectCB.pIn <= pIn;
        pOut = this.vif.projectCB.pOut;
        
    endtask: driverWrite
    
endclass: projectDriver