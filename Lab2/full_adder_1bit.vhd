-- Lab Section 201, Group Number 8, Leo Gao and Mostafa Elmansory
library ieee; 
use ieee.std_logic_1164.all; 

entity full_adder_1bit is 
     port (
        INPUT_B, INPUT_A, CARRY_IN : in std_logic; -- Inputs: Two Operands and Carry-In
        FULL_ADDER_CARRY_OUTPUT : out std_logic;   -- Output : Carry-out
        FULL_ADDER_SUM_OUTPUT: out std_logic       -- Output : Sum
     ); 

end  full_adder_1bit; 


architecture adder_logic of full_adder_1bit is 

 signal HALF_ADDER_SUM_OUTPUT: std_logic; 
 signal HALF_ADDER_CARRY_OUTPUT: std_logic; 
 signal SECOND_AND: std_logic; 

begin 

-- By Using Signal to achieve a step by step, Easy to review architecture.

   HALF_ADDER_SUM_OUTPUT <= INPUT_B XOR INPUT_A; -- Half-Adder Sum signal logic
   HALF_ADDER_CARRY_OUTPUT <= INPUT_B AND INPUT_A; -- Half-Adder Output signal Logic
   FULL_ADDER_SUM_OUTPUT <= HALF_ADDER_SUM_OUTPUT XOR CARRY_IN; -- Sum Output Logic
   SECOND_AND <= CARRY_IN AND HALF_ADDER_SUM_OUTPUT; -- logic of a middle step (in the grah indicating as the second and gate)
   FULL_ADDER_CARRY_OUTPUT <= HALF_ADDER_CARRY_OUTPUT OR SECOND_AND; -- Carry-out Output Logic

end adder_logic; 