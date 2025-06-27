-- Lab Section 201, Team 8, Leo Gao and Mostafa Elmansory
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LogicalStep_Lab4_top IS
   PORT
	(
    clkin_50	    : in	std_logic;							-- The 50 MHz FPGA Clockinput
	rst_n			: in	std_logic;							-- The RESET input (ACTIVE LOW)
	pb_n			: in	std_logic_vector(3 downto 0);       -- The push-button inputs (ACTIVE LOW)
 	sw   			: in  	std_logic_vector(7 downto 0);       -- The switch inputs
    leds			: out 	std_logic_vector(7 downto 0);	    -- for displaying the the lab4 project details
	-------------------------------------------------------------
	-- you can add temporary output ports here if you need to debug your design 
	-- or to add internal signals for your simulations
	-------------------------------------------------------------
	
   seg7_data 	: out 	std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic							-- seg7 digi selectors
	);
END LogicalStep_Lab4_top;

ARCHITECTURE SimpleCircuit OF LogicalStep_Lab4_top IS

-- First declare all the components used in the top file

   component segment7_mux port (
             clk        	: in  	std_logic := '0';
			 DIN2 			: in  	std_logic_vector(6 downto 0);	--bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DIN1 			: in  	std_logic_vector(6 downto 0); --bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
   );
   end component;

   component clock_generator port (
			sim_mode			: in boolean;
			reset				: in std_logic;
            clkin      		    : in std_logic;
			sm_clken			: out std_logic;
			blink		  		: out std_logic
  );
   end component;

    component pb_filters port (
			clkin				: in std_logic;
			rst_n				: in std_logic;
			rst_n_filtered	    : out std_logic;
			pb_n				: in  std_logic_vector (3 downto 0);
			pb_n_filtered	    : out	std_logic_vector(3 downto 0)							 
 );
   end component;

	component pb_inverters port (
			rst_n				: in  std_logic;
			rst				    : out	std_logic;							 
			pb_n_filtered	    : in  std_logic_vector (3 downto 0);
			pb					: out	std_logic_vector(3 downto 0)							 
  );
   end component;
	
	component Moore_Machine IS Port (
 clkin_50, reset, clK_en, blink_sig			: IN std_logic;
 NSrequest, EWrequest						: IN std_logic;
 Mode                                       : IN std_logic;
 greenns, yellowns, redns				: OUT std_logic;
 greenew, yellowew, redew				: OUT std_logic;
 NS_CROSSINGS, EW_CROSSINGS, NSREGISTER_CLEAR, EWREGISTER_CLEAR : OUT std_logic;
 stateout                           : OUT std_logic_vector (3 downto 0)
 
 );
END component;
	
  	component synchronizer port(
			clk					: in std_logic;
			reset				: in std_logic;
   		    din					: in std_logic;
			dout				: out std_logic
			);
   end component;
   
  component holding_register port (
			clk					: in std_logic;
			reset					: in std_logic;
		   register_clr		: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
  end component;			
----------------------------------------------------------------------------------------------------
	CONSTANT	sim_mode								: boolean := false;  -- set to FALSE for LogicalStep board downloads																						-- set to TRUE for SIMULATIONS
	SIGNAL rst, rst_n_filtered, synch_rst			    : std_logic; -- Reset signals
	SIGNAL sm_clken, blink_sig							: std_logic; -- Clock enable and blink signals
	SIGNAL pb_n_filtered, pb							: std_logic_vector(3 downto 0);  -- pbs and inverted pbs
	
	signal NS_CROSSING, EW_CROSSING		: std_logic; -- North-South and East-West crossing signals

	-- North-South traffic light control signals down to red, yellow, green
	signal gsolid: std_logic;
	signal asolid: std_logic;
	signal rsolid: std_logic;

    -- East-West traffic light control signals down to red, yellow, green
	signal gsolidEW: std_logic;
	signal asolidEW: std_logic;
	signal rsolidEW: std_logic;

	signal lightNS:  std_logic_vector (6 downto 0);	-- Overall North-South traffic light control
	signal lightEW: std_logic_vector (6 downto 0); -- Overall East-West traffic light control signals
	
	-- North-South and East-West crossing requests
	signal requestNS : std_logic;
	signal requestEW : std_logic;

	-- Register Clear Signals
	signal REGISTER_CLEARNS : std_logic;
	signal REGISTER_CLEAREW : std_logic;
	
	signal sync_out : std_logic_vector(1 downto 0); -- Synchronized outputs

	signal Mode_Control : std_logic; --Mode control signal (Offline and Online Mode)
	
BEGIN

-- Connect the leds to the signals

 leds(0)<= NS_CROSSING;
 leds(1)<= requestNS;
 leds(2)<= EW_CROSSING;
 leds(3) <= requestEW;

-- Use traffic light control signals down to red, yellow, green for Overall traffic light control signals
-- For it to be recognized by segment7_mux
 
lightNS <=  asolid & "00" & gsolid & "00" & rsolid;
lightEW <=  asolidEW & "00" & gsolidEW & "00" & rsolidEW;
----------------------------------------------------------------------------------------------------
INST0: pb_filters		port map (clkin_50, rst_n, rst_n_filtered, pb_n, pb_n_filtered); -- Make all buttons (pbs) sychronized
INST1: pb_inverters		port map (rst_n_filtered, rst, pb_n_filtered, pb);  -- Invert all the buttons from polarity low to polarity high
INST2: synchronizer     port map (clkin_50,'0', rst, synch_rst); -- Sychronize the reset signal with set to 0

-- Implement the clock generator with sychronized reset signal for clock enable signals and blink signals
INST3: clock_generator 	port map (sim_mode, synch_rst, clkin_50, sm_clken, blink_sig);  

INST5: synchronizer port map(clkin_50, synch_rst, pb(1), sync_out(1)); -- Sychronize the pb(1) with sychronzied reset signal
-- Connected Sychronized pb(1) signal with holding register to service the Moore Machine
INST6: holding_register port map (clkin_50, synch_rst, REGISTER_CLEAREW, sync_out(1), requestEW); 

INST7: synchronizer port map(clkin_50, synch_rst, pb(0), sync_out(0)); -- Sychronize the pb(0) with sychronzied reset signal
-- Connected Sychronized pb(0) signal with holding register to service the Moore Machine
INST8: holding_register port map (clkin_50, synch_rst, REGISTER_CLEARNS, sync_out(0), requestNS);

-- Sychronize the sw(0) for (online and offline mode control) with sychronzied reset signal
INST9: synchronizer port map(clkin_50, synch_rst, sw(0), Mode_Control);

-- Connect all the signals to Moore Machine to generate required outputs
INST10: Moore_Machine PORT MAP(clkin_50, synch_rst, sm_clken, blink_sig, requestNS, requestEW, Mode_Control, gsolid, asolid, rsolid,  gsolidEW, asolidEW, rsolidEW, NS_CROSSING, EW_CROSSING, REGISTER_CLEARNS, REGISTER_CLEAREW, leds(7 downto 4));

-- Convert relevant outputs onto led screen (EW and NS yellow, green, red light signals)
INST11: segment7_mux port map(clkin_50, lightEW, lightNS , seg7_data (6 downto 0), seg7_char1, seg7_char2);

END SimpleCircuit;
