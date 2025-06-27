-- Lab Section 201, Group Number 8, Leo Gao and Mostafa Elmansory
library ieee;
use ieee.std_logic_1164.all;

ENTITY PB_Inverters IS
   PORT
	(
	   pb_n : IN std_logic_vector(3 downto 0);  -- Original 4-bit Input
		pb   : OUT std_logic_vector(3 downto 0)  -- After Inverting polarity Output
   );
END PB_Inverters;

ARCHITECTURE gates OF PB_Inverters IS


BEGIN

pb <= not(pb_n); -- Use negation to reverse polarity of the buttons used

END gates;
