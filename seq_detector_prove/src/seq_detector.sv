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
   always_comb begin: set_next_state
     next = state;
     unique case (state)
       S0 : if (seq_in) next = S1; else next = S0;
       S1 : if (seq_in) next = S1; else next = S2;
       S2 : if (seq_in) next = S3; else next = S0;
       S3 : if (seq_in) next = S4; else next = S2;
       S4 : if (seq_in) next = S1; else next = S2;
     endcase
   end: set_next_state

   // Registered output logic
   always_ff @(posedge clk, posedge reset)
     if (reset) detect_out <= 1'b0;
     else       detect_out <= (state == S4);

`ifdef FORMAL

restrict property (!reset != $initstate);
//initial state = S0;

default clocking @(posedge clk);
endclocking

default disable iff (reset);

sequence SEQ;
  seq_in ##1 !seq_in ##1 seq_in[*2];
endsequence

property CHK_SEQ_DETECT;
   SEQ |=> ##1 detect_out;
endproperty;

ASSERT_CHK_SEQ_DETECT: assert property (CHK_SEQ_DETECT);
ASSERT_ONE_HOT_STATE_ENCODING: assert property ($onehot(state));
SEQ_DETECT_WITNESS: cover property (SEQ ##2 detect_out);

`endif

endmodule
