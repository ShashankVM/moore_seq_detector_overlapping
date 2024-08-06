module seq_detector(
   input seq_in, clk, reset,
   output logic detect_out
);

   //one-hot encoding of FSM
   enum logic [4:0] {S0 = 5'b00001, S1 = 5'b00010, S2 = 5'b00100, S3 = 5'b01000, S4 = 5'b10000}  state, next;


   //state registers
   always_ff @(posedge clk or posedge reset)
     if (reset) state <= S0;
     else       state <= next;

   // Next state assignment logic
   always_comb begin
     next = state;
     unique case (state)
       S0 : if (seq_in) next = S1; else next = S0;
       S1 : if (seq_in) next = S1; else next = S2;
       S2 : if (seq_in) next = S3; else next = S0;
       S3 : if (seq_in) next = S4; else next = S2;
       S4 : if (seq_in) next = S1; else next = S2;
     endcase
   end

   // Registered output logic
   always_ff @(posedge clk, posedge reset)
     if (reset) detect_out <= 1'b0;
     else       detect_out <= (state == S4);


ASSUME_VALID_STATE1: assume property ($onehot(state));
ASSUME_VALID_STATE2: assume property (reset |-> (state == S0));

ASSERT_OVERLAPPING_PROPERTY: assert property (@(posedge clk) (state == S4) |-> (next != S0));
ASSERT_CHK_SEQ_DETECT: assert property (@(posedge clk) disable iff (reset) seq_in ##1 !seq_in ##1 seq_in ##1 seq_in  |-> ##2 detect_out);
ASSERT_BI: assert property ( @(posedge clk)  disable iff (reset) detect_out |-> (($past(seq_in, 2) == 1) && ($past(seq_in, 3) == 1) && ($past(seq_in, 4) == 0) && ($past(seq_in, 5) == 1)) );

COVER_NON_OVERLAPPING_SEQUENCE: cover property (seq_in ##1 !seq_in ##1 seq_in ##1 seq_in ##2 !seq_in);
COVER_OVERLAPPING_SEQUENCE: cover property (seq_in ##1 !seq_in ##1 seq_in ##1 seq_in ##1 !seq_in ##1 seq_in ##1 seq_in ##3 seq_in);



endmodule
