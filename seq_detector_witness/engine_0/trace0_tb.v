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
  wire [0:0] PI_clk = clock;
  reg [0:0] PI_reset;
  reg [0:0] PI_seq_in;
  seq_detector UUT (
    .clk(PI_clk),
    .reset(PI_reset),
    .seq_in(PI_seq_in)
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
    // UUT.$auto$async2sync.\cc:139:execute$204  = 5'b00001;
    // UUT.$auto$async2sync.\cc:171:execute$211  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$213  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$215  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$217  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$219  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$221  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$223  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$225  = 1'b0;
    // UUT.$auto$async2sync.\cc:171:execute$227  = 1'b0;
    UUT._witness_.anyinit_verific_detect_out_reg_seq_detector_sv_30_47 = 1'b0;

    // state 0
    PI_reset = 1'b0;
    PI_seq_in = 1'b1;
  end
  always @(posedge clock) begin
    // state 1
    if (cycle == 0) begin
      PI_reset <= 1'b0;
      PI_seq_in <= 1'b0;
    end

    // state 2
    if (cycle == 1) begin
      PI_reset <= 1'b0;
      PI_seq_in <= 1'b1;
    end

    // state 3
    if (cycle == 2) begin
      PI_reset <= 1'b0;
      PI_seq_in <= 1'b1;
    end

    // state 4
    if (cycle == 3) begin
      PI_reset <= 1'b0;
      PI_seq_in <= 1'b0;
    end

    // state 5
    if (cycle == 4) begin
      PI_reset <= 1'b0;
      PI_seq_in <= 1'b0;
    end

    // state 6
    if (cycle == 5) begin
      PI_reset <= 1'b0;
      PI_seq_in <= 1'b0;
    end

    genclock <= cycle < 6;
    cycle <= cycle + 1;
  end
endmodule
