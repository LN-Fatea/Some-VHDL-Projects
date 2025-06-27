-- Lab Section 201, Group Number 8, Leo Gao and Mostafa Elmansory
library ieee;
use ieee.std_logic_1164.all;

entity hex_mux is
port (
	 hex_num3, hex_num2, hex_num1, hex_num0 : in std_logic_vector(3 downto 0);
	 mux_select										: in std_logic_vector(1 downto 0); -- 2-bit Signal for Selection
	 hex_out											: out std_logic_vector(3 downto 0) --hex output
);
end hex_mux;

architecture mux_logic of hex_mux is

begin

	 with mux_select(1 downto 0) select
	 hex_out <= hex_num0 when "00", -- select hex_num0 when mux_select is "00"
				   hex_num1 when "01", -- select hex_num1 when mux_select is "01"
				   hex_num2 when "10", -- select hex_num2 when mux_select is "10"
				   hex_num3 when "11"; -- select hex_num3 when mux_select is "11"
				  
end mux_logic;

