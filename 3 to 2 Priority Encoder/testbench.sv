import uvm_pkg::*;

`include "uvm_macros.svh"

`include "Sequencer.svh"
`include "Driver.svh"
//`include "Monitor.svh"
`include "Agent.svh"
//`include "Scoreboard.svh"
`include "Environment.svh"
`include "Test.svh"

module testbenchTop;

    //Clock and reset signal
    bit clk;
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
    virtualIf intf(pIn, pOut);
    
    //DUT instance
    priority_encoder DUT(
    
        .priority_in(pIn),
        .priority_out(pOut)
    
    );
    
    //Run test
    initial begin
        
        uvm_config_db#(virtual virtualIf)::set(null, "uvm_test_top", "vif", intf);
        run_test("projectTest");
        
    end
    
endmodule