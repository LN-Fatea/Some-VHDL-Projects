-- Lab Section 201, Group Number 8, Leo Gao and Mostafa Elmansory
library ieee;
use ieee.std_logic_1164.all;

entity Logic_Processor is
port (
	 logic_in0, logic_in1                : in std_logic_vector(3 downto 0);
	 logic_select                       : in std_logic_vector(1 downto 0); -- 2-bit Selection Signal 
	 logic_out										: out std_logic_vector(3 downto 0) -- 4-bit logic output
);
end Logic_Processor;

architecture process_logic of Logic_Processor is

begin

	with logic_select(1 downto 0) select
	logic_out <= (logic_in0 AND logic_in1) when "00",     -- When select is "00", And Gate between Inputs
				    (logic_in0 OR logic_in1) when  "01",  -- When select is "01", OR Gate between Inputs
				    (logic_in0 XOR logic_in1) when "10",  -- When select is "10", XOR Gate between Inputs
				    (logic_in0 XNOR logic_in1) when "11";  -- When select is "11", XNOR Gate between Inputs
				  
end process_logic;