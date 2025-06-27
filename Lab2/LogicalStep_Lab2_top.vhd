-- Lab Section 201, Group Number 8, Leo Gao and Mostafa Elmansory
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port ( --Import SevenSegment Components
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port ( -- Import  segment7_mux Components
		clk		: in std_logic := '0';
		DIN2		: in std_logic_vector(6 downto 0); -- 7-bit input for seven segment display (digit 2)
		DIN1		: in std_logic_vector(6 downto 0); -- 7-bit input for seven segment display (digit 1)
		DOUT		: out std_logic_vector(6 downto 0); -- Output to seven segment display
		DIG2		: out std_logic; --Enable for digit 2
		DIG1		: out std_logic --Enable for digit 1
	);
	end component;
	
	component Logic_Processor port ( -- Import Logic_Processor Components
	logic_in0,logic_in1 : in std_logic_vector(3 downto 0);
	logic_select : in std_logic_vector(1 downto 0);
	logic_out : out std_logic_vector(3 downto 0)
   );
   end component;
	
   component PB_Inverters port( -- Import the functions of PB Inverters
	    pb_n     : IN std_logic_vector(3 downto 0);
		 pb       : OUT std_logic_vector(3 downto 0)  
    );
    end component;
	 
	component full_adder_4bit port( -- Import the functions of full_adder_4bit
      BUS0_b3, BUS1_b3, BUS0_b2, BUS1_b2, BUS0_b1, BUS1_b1, BUS0_b0, BUS1_b0 : in std_logic;
	   Carry_In                                                               : in std_logic;
	   Carry_Out3                                                             : out std_logic;
      SUM                                                                    : out std_logic_vector(3 downto 0)
    );
    end component;
	 
	 component logic_process_2 port( -- Import the functions of logic_process_2
    logic_n0, logic_n1     : in std_logic_vector(3 downto 0);
	 logic_select2          : in std_logic;
	 logic_out2             : out std_logic_vector(3 downto 0)
    ); 
    end component;
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--

    -- Hex Valuse From Switches
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B		: std_logic_vector(3 downto 0);
	
	-- Seven Segment display outputs
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	
	-- Push Button State (Pressed or not Pressed)
    signal pb         : std_logic_vector(3 downto 0);

	-- Carry Out with three 0 digits in front
	signal signal_C    : std_logic_vector(3 downto 0);

	--Sum output from full adder 4 bit
	signal hex_sum    : std_logic_vector(3 downto 0);
	
	--Carrry-out output from full adder 4 bit
	signal carry_out  : std_logic;
	signal select_21  : std_logic;

	-- outputs from mux
	signal Operand_A    : std_logic_vector(3 downto 0);
	signal Operand_B    : std_logic_vector(3 downto 0);
	
	
-- Here the circuit begins

begin
	
	hex_A <= sw(3 downto 0); -- Assign bit 0 to bit 3 of switch input to hex_A
	hex_B <= sw(7 downto 4); -- Assign bit 4 to bit 7 of switch input to hex_B
	signal_C <= "000" & carry_out; -- Carry-Out to carry three 0 digits in front


--COMPONENT HOOKUP
--
-- generate seven segment coding

    -- Invert inputs (Reverse the polarity o fthe buttons used)
	INST1: PB_Inverters port map(pb_n, pb);

	-- Logic Processor to output results using different bitwise operations to the leds
	INST2: Logic_Processor port map(hex_B, hex_A, pb(1 downto 0),leds(3 downto 0)); 

	-- Convert hexdecimal number to seven bit signal to display
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);

	-- Use 4-bit adder
	INST4: full_adder_4bit port map(hex_A(3), hex_B(3), hex_A(2), hex_B(2), hex_A(1), hex_B(1), hex_A(0), hex_B(0),'0', carry_out, hex_sum);
	-- two to one mux to select
	INST5: logic_process_2 port map(hex_B, signal_C, pb(2), Operand_A);
	INST6: logic_process_2 port map(hex_A, hex_sum, pb(2), Operand_B);

	-- Seven segment display of two digits on logic board
	INST7: SevenSegment port map(Operand_B, seg7_A);
    INST8: SevenSegment port map(Operand_A, seg7_B);
 
end SimpleCircuit;

