-- Lab Section 201, Group Number 8, Leo Gao and Mostafa Elmansory
library ieee;
use ieee.std_logic_1164.all;

-- This is to perform a two to one mux

entity logic_process_2 is 
  port(
    logic_n0, logic_n1     : in std_logic_vector(3 downto 0); -- Two 4-bit Input signals
	 logic_select2          : in std_logic; -- 2-bit Selection Signal input 
	 logic_out2             : out std_logic_vector(3 downto 0) -- 4-bit Signal Output
  );
  end logic_process_2;
  
  architecture logic_2 of logic_process_2 is
  
  begin -- Use with-select to assign the output based on selection signal 

      with logic_select2 select
		logic_out2 <= logic_n0 when '0', -- When Selection Signal is '0', output is logic_n0
		              logic_n1 when '1'; -- When Selection Signal is '1', output is logic_n1
  end logic_2;