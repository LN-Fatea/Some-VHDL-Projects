Library ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY VHDL_polarity_ctrl IS
	PORT (
			Polarity_High, IN_1, IN_2, IN_3, IN_4	:IN std_logic;
			OUT_1, OUT_2, OUT_3, OUT_4 : OUT std_logic
			);
END VHDL_polarity_ctrl;

ARCHITECTURE simple_gates OF VHDL_polarity_ctrl IS

BEGIN

OUT_1 <= Polarity_High XNOR IN_1;
OUT_2 <= Polarity_High XNOR IN_2;
OUT_3 <= Polarity_High XNOR IN_3;
OUT_4 <= Polarity_High XNOR IN_4;

END simple_gates;