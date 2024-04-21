interface projectInterface (input bit clk);
    
    bit [2:0] pIn;
    bit [1:0] pOut;
    
    //Clocking block
    clocking projectCB @(posedge clk);
        input pIn;
        output pOut;
    endclocking: projectCB
    
    //Monitor clocking block
    clocking monitorCB @(posedge clk);
        input pIn, pOut;
    endclocking: monitorCB
    
    modport project(clocking projectCB);
    modport passive(clocking monitorCB);
    
endinterface: projectInterface