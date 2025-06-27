library ieee;
use ieee.std_logic_1164.all;


entity holding_register is port (

			clk					: in std_logic;
			reset				: in std_logic;
			register_clr		: in std_logic;
			din					: in std_logic;
			dout				: out std_logic
  );
 end holding_register;
 
 architecture circuit of holding_register is

	Signal sreg				: std_logic;
	signal s1            : std_logic;
	signal s2            : std_logic;
	signal d_input            : std_logic;


BEGIN


s1 <= (din or sreg);
s2 <= not (register_clr or reset);

d_input <= (s1 and s2);

	
	
	PROCESS(clk)
	BEGIN
	  if(rising_edge(clk)) then
	    sreg <= d_input;
		 dout <= d_input;
		end if;
	END PROCESS;

end;