-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "02/05/2025 16:36:18"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          LogicalStep_Lab2_top
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY LogicalStep_Lab2_top_vhd_vec_tst IS
END LogicalStep_Lab2_top_vhd_vec_tst;
ARCHITECTURE LogicalStep_Lab2_top_arch OF LogicalStep_Lab2_top_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clkin_50 : STD_LOGIC;
SIGNAL leds : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL pb_n : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL seg7_char1 : STD_LOGIC;
SIGNAL seg7_char2 : STD_LOGIC;
SIGNAL seg7_data : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL sw : STD_LOGIC_VECTOR(7 DOWNTO 0);
COMPONENT LogicalStep_Lab2_top
	PORT (
	clkin_50 : IN STD_LOGIC;
	leds : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	pb_n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	seg7_char1 : OUT STD_LOGIC;
	seg7_char2 : OUT STD_LOGIC;
	seg7_data : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	sw : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : LogicalStep_Lab2_top
	PORT MAP (
-- list connections between master ports and signals
	clkin_50 => clkin_50,
	leds => leds,
	pb_n => pb_n,
	seg7_char1 => seg7_char1,
	seg7_char2 => seg7_char2,
	seg7_data => seg7_data,
	sw => sw
	);

-- sw[7]
t_prcs_sw_7: PROCESS
BEGIN
	sw(7) <= '0';
	WAIT FOR 400000 ps;
	sw(7) <= '1';
	WAIT FOR 800000 ps;
	sw(7) <= '0';
WAIT;
END PROCESS t_prcs_sw_7;

-- sw[6]
t_prcs_sw_6: PROCESS
BEGIN
	sw(6) <= '1';
	WAIT FOR 400000 ps;
	sw(6) <= '0';
	WAIT FOR 400000 ps;
	sw(6) <= '1';
	WAIT FOR 400000 ps;
	sw(6) <= '0';
WAIT;
END PROCESS t_prcs_sw_6;

-- sw[5]
t_prcs_sw_5: PROCESS
BEGIN
	sw(5) <= '1';
	WAIT FOR 800000 ps;
	sw(5) <= '0';
WAIT;
END PROCESS t_prcs_sw_5;

-- sw[4]
t_prcs_sw_4: PROCESS
BEGIN
	sw(4) <= '1';
	WAIT FOR 400000 ps;
	sw(4) <= '0';
WAIT;
END PROCESS t_prcs_sw_4;

-- sw[3]
t_prcs_sw_3: PROCESS
BEGIN
	sw(3) <= '1';
	WAIT FOR 400000 ps;
	sw(3) <= '0';
	WAIT FOR 400000 ps;
	sw(3) <= '1';
WAIT;
END PROCESS t_prcs_sw_3;

-- sw[2]
t_prcs_sw_2: PROCESS
BEGIN
LOOP
	sw(2) <= '0';
	WAIT FOR 400000 ps;
	sw(2) <= '1';
	WAIT FOR 400000 ps;
	IF (NOW >= 1600000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_sw_2;

-- sw[1]
t_prcs_sw_1: PROCESS
BEGIN
LOOP
	sw(1) <= '0';
	WAIT FOR 800000 ps;
	sw(1) <= '1';
	WAIT FOR 800000 ps;
	IF (NOW >= 1600000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_sw_1;

-- sw[0]
t_prcs_sw_0: PROCESS
BEGIN
	sw(0) <= '1';
WAIT;
END PROCESS t_prcs_sw_0;

-- pb_n[1]
t_prcs_pb_n_1: PROCESS
BEGIN
	pb_n(1) <= '1';
	WAIT FOR 200000 ps;
	FOR i IN 1 TO 3
	LOOP
		pb_n(1) <= '0';
		WAIT FOR 200000 ps;
		pb_n(1) <= '1';
		WAIT FOR 200000 ps;
	END LOOP;
	pb_n(1) <= '0';
WAIT;
END PROCESS t_prcs_pb_n_1;

-- pb_n[0]
t_prcs_pb_n_0: PROCESS
BEGIN
LOOP
	pb_n(0) <= '1';
	WAIT FOR 100000 ps;
	pb_n(0) <= '0';
	WAIT FOR 100000 ps;
	IF (NOW >= 1600000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_pb_n_0;
END LogicalStep_Lab2_top_arch;
