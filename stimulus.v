`define TRUE 1'b1
`define FALSE 1'b0

module stimulus;

    wire [1:0] MAIN_SIG , CNTRY_SIG;
    reg CAR_ON_CNTRY_RD;
    reg CLOCK, CLEAR;

    //signal controller instatiation
    sig_control SC (MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD, CLOCK, CLEAR);

    initial begin
        $monitor ($time, "Main Sig =%b Country Sig = %b Car_on_cntry = %b", MAIN_SIG,CNTRY_SIG,CAR_ON_CNTRY_RD);

    end


    //CLOCK SET UP
    initial begin
        CLOCK = `FALSE;
        forever #5 CLOCK = ~CLOCK;
    end

    //CONTROL CLEAR SIGNAL
    initial begin
        CLEAR = `TRUE;
        repeat (5) @(negedge CLOCK);
        CLEAR = `FALSE;
    end


    //APPLY STIMULUS
    initial begin
        CAR_ON_CNTRY_RD =`FALSE;
        repeat (20) @(negedge CLOCK) ; CAR_ON_CNTRY_RD =`TRUE;
        repeat (10) @(negedge CLOCK) ; CAR_ON_CNTRY_RD =`FALSE;

        repeat (20) @(negedge CLOCK) ; CAR_ON_CNTRY_RD =`TRUE;
        repeat (10) @(negedge CLOCK) ; CAR_ON_CNTRY_RD =`FALSE;

        repeat (20) @(negedge CLOCK) ; CAR_ON_CNTRY_RD =`TRUE;
        repeat (10) @(negedge CLOCK) ; CAR_ON_CNTRY_RD =`FALSE;

        repeat(10)  @(negedge CLOCK) ; $stop;
    end
    endmodule