`ifndef VERILATOR
module testbench;
  reg [4095:0] vcdfile;
  reg clock;
`else
module testbench(input clock, output reg genclock);
  initial genclock = 1;
`endif
  reg genclock = 1;
  reg [31:0] cycle = 0;
  reg [0:0] PI_seq_in;
  wire [0:0] PI_clk = clock;
  reg [0:0] PI_reset;
  seq_detector UUT (
    .seq_in(PI_seq_in),
    .clk(PI_clk),
    .reset(PI_reset)
  );
`ifndef VERILATOR
  initial begin
    if ($value$plusargs("vcd=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, testbench);
    end
    #5 clock = 0;
    while (genclock) begin
      #5 clock = 0;
      #5 clock = 1;
    end
  end
`endif
  initial begin
`ifndef VERILATOR
    #1;
`endif
    // UUT.$auto$async2sync.\cc:171:execute$276  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$278  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$280  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$282  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$284  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$286  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$288  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$290  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$292  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$294  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$296  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$298  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$300  = 1'b0;
    UUT._witness_.anyinit_verific_detect_out_reg_seq_detector_sv_30_67 = 1'b0;
    UUT._witness_.anyinit_verific_state_reg_seq_detector_sv_13_54 = 5'b00000;

    // state 0
    PI_seq_in = 1'b1;
    PI_reset = 1'b1;
  end
  always @(posedge clock) begin
    // state 1
    if (cycle == 0) begin
      PI_seq_in <= 1'b1;
      PI_reset <= 1'b0;
    end

    // state 2
    if (cycle == 1) begin
      PI_seq_in <= 1'b0;
      PI_reset <= 1'b0;
    end

    // state 3
    if (cycle == 2) begin
      PI_seq_in <= 1'b1;
      PI_reset <= 1'b0;
    end

    // state 4
    if (cycle == 3) begin
      PI_seq_in <= 1'b1;
      PI_reset <= 1'b0;
    end

    // state 5
    if (cycle == 4) begin
      PI_seq_in <= 1'b0;
      PI_reset <= 1'b0;
    end

    // state 6
    if (cycle == 5) begin
      PI_seq_in <= 1'b0;
      PI_reset <= 1'b0;
    end

    // state 7
    if (cycle == 6) begin
      PI_seq_in <= 1'b0;
      PI_reset <= 1'b0;
    end

    genclock <= cycle < 7;
    cycle <= cycle + 1;
  end
endmodule
