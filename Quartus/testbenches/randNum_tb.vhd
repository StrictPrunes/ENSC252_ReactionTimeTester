-- File: randNum_tb.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: test bench for random number generator
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY randNum_tb is
END randNum_tb;

ARCHITECTURE Behaviour of randNum_tb is
COMPONENT getRandNum IS --the component we would like to test
	PORT (	e : in std_logic;
		clock : in std_logic;
		rand : out std_logic_vector(3 downto 0));
	END COMPONENT;

	--clock generation
	constant clk_hz : integer := 50e6; --f = 50 Mhz clock
	constant clk_period : time := 1 sec / clk_hz; --1/f = T = 20 ns period

	--DUT signals required
	SIGNAL tb_e : std_logic := '1';
	SIGNAL tb_clock : std_logic := '1'; --DUT's clock input.
	SIGNAL tb_d : std_logic_vector(3 downto 0) := "0000" ;
	
	BEGIN
	
		DUT : getRandNum PORT MAP(tb_e, tb_clock, tb_d);

		tb_clock <= NOT tb_clock after clk_period / 10;
		tb_e <= NOT tb_e after clk_period;
		
END Behaviour;
