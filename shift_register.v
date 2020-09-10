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


module shift_register (Q, CLK, RST, LOAD, SHIFT, DIR, DATA, SER_IN);
output reg [7:0] Q;
input CLK, RST, LOAD,DIR, SHIFT, SER_IN;
input [7:0] DATA;
reg [7:0] temp;

always @ (posedge CLK or posedge RST) 
begin
if (RST)
	Q<=8'b0;
else if(LOAD)
begin
	Q<=DATA;
	temp<=DATA;
end 
else if(SHIFT) //DIR =1 Shift left
begin
	if(DIR)
	begin
	 temp = {temp[6:0], SER_IN};
	 Q<=temp;
	end
	else
	begin
	 temp = {SER_IN, temp[7:1]};
	 Q<=temp;
	end
end
end
endmodule
