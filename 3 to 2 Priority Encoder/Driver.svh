class projectDriver extends uvm_driver#(projectSequenceItem);

    //Virtual interface
    virtual virtualIf vif;

    `uvm_component_utils(projectDriver)
    
    //Constructor
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    //Build phase
    function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);
        
        if(!uvm_config_db#(virtual virtualIf)::get(this, "", "vif", vif))
            `uvm_fatal("NO_VIF", {"Virtual interface must be set for: ", get_full_name(), ".vif"});
            
    endfunction: build_phase
    
    //Run phase
    virtual task run_phase(uvm_phase phase);
    
        forever begin
        
        seq_item_port.get_next_item(req);
        drive();
        seq_item_port.item_done();
        
        end
        
    endtask: run_phase
    
    //Drive
    virtual task drive();
    
        req.print();
        this.vif.master_cb.pIn <= req.pIn;
        this.vid.master_cb.pOut <= req.pOut;
        
    endtask: drive

endclass: projectDriver