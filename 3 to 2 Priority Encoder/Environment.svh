class projectEnvironment extends uvm_env;

    //Agent and scoreboard instance
    projectAgent agent;
    //projectScoreboard scoreboard;
    
    `uvm_component_utils(projectEnvironment)
    
    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    //Build phase
    function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);
        
        agent = projectAgent::type_id::create("agent", this);
        //scoreboard = projectScoreboard::type_id::create("scoreboard", this);
    
    endfunction: build_phase
    
    //Connect phase
    function void connect_phase(uvm_phase phase);
        //agent.monitor.item_collected_port.connect(scoreboard.item_collected_export);
    endfunction: connect_phase
    
    endclass: projectEnvironment