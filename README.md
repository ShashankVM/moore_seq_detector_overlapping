# moore_seq_detector_overlapping
Formally verified "1011" overlapping sequence detector - Moore FSM
---
Waveform of witness cover opened in GTKWave:
  ![Waveform of covered statement opened in GTKWave](https://github.com/ShashankVM/moore_seq_detector_overlapping/blob/main/moore_seq.png)
- This is a formally verified Moore FSM based overlapping sequence detector with registered outputs.
- **Tools & Technologies:** SystemVerilog, SystemVerilog Assertions, Yosys, Tabby CAD Suite
- **Note:** Assertion passing using Bounded Model Checking. Assertion failing for Full Proof, in discussions with YosysHQ team to root cause it.
