import uvm_pkg::*;

`include "uvm_macros.svh"

`include "projectSequencer.svh"
`include "projectDriver.svh"
`include "projectMonitor.svh"
`include "projectAgent.svh"
`include "projectScoreboard.svh"
`include "projectEnvironment.svh"
`include "projectTest.svh"
`include "projectInterface.svh"
`include "projectSequenceItem"
`include "projectSequence"

module testbenchTop;

    bit clk = 0;
    bit reset;
    bit [2:0] pIn;
    bit [1:0] pOut;
    
    //Clock generation
    always #5 clk = ~clk;
    
    //Reset generation
    initial begin
        reset = 1;
        #5
        reset = 0;
    end
    
    //Creating instance of interface
    projectInterface projectInterface(.clk(clk), .pIn(pIn), .pOut(pOut));
    
    //DUT instance
    priority_encoder DUT(
    
        .priority_in(pIn),
        .priority_out(pOut)
    
    );
    
    //Run test
    initial begin
        
        uvm_config_db#(virtual virtualInterface)::set(null, "uvm_test_top", "vif", projectInterface);
        run_test("projectTest");
        
    end
    
endmodule