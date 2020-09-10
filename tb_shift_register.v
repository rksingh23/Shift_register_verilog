//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// File: shift_register.v
// Purpose: Design an edge triggered 8-bit shift register with a synchronous load, serial input.
// Concept: 1. When “RST” is active, it resets (clears) the shift-register contents (zero).
//          2. When “LOAD” is active, the value of DATA is written to the shift register
//          3. When “SHIFT” is active, depending on value of “DIR” signal, the data in the shift register (Q [7:0]) shifts left or right by one-bit. “SER_IN” bit overwrites LSB or MSB in the left-shift or right-shift operation respectively.
//          4. When RST”, “LOAD”, and “SHIFT” signals are inactive, the current value in the shift register Q [7:0] remains unchanged1. Round Robin Rotator takes in four requests at a time and generates one grant with priority every clock cycle.
//
// Owner: Rohit Kumar Singh
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


`timescale 1ns/1ns

module shift_register_tb();
wire [7:0] Q;
reg CLK, RST, LOAD,DIR, SHIFT, SER_IN;
reg [7:0] DATA;

shift_register dut (.Q(Q),.CLK(CLK),.RST(RST),.LOAD(LOAD),
					.SHIFT(SHIFT),.DIR(DIR),.DATA(DATA),.SER_IN(SER_IN));
					

always #2 CLK=~CLK;

initial begin
CLK=0;
DATA=8'b0;
LOAD=0;
RST=1;
#7 
RST=0;
#7
DATA<=8'b 01010101;
LOAD=1;
#7
LOAD=0;
#2;
SHIFT=1;
DIR=1;
SER_IN=0;
#34;
SHIFT=1;
DIR=1;
SER_IN=1;
#8
DATA<=8'b 11111111;
LOAD=1;
#7;
LOAD=0;
#2;
SHIFT=1;
DIR=0;
SER_IN=0;
#34;
SHIFT=0;
#10;
end

endmodule
