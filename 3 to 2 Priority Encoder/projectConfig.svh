class projectConfig extends uvm_object;

    `uvm_object_utils(projectConfig)
    virtual projectInterface vif;
    
    function new (string name = "projectConfig");
        super.new(name);
    endfunction
    
endclass: projectConfig