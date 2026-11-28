-- File: BCDWraparound_tb.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Testbench for BCDCount.vhd; checks the count 0 to 9 and the wraparound from 9 to 0
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY BCDWraparound_tb is
END BCDWraparound_tb;

ARCHITECTURE Behaviour of BCDWraparound_tb is
COMPONENT BCDCount IS --the component we would like to test
	PORT (e0 : in std_logic;
		clear : in std_logic;
		clock : in std_logic;
		BCD0 : out std_logic_vector(3 downto 0));
	END COMPONENT;

	--clock generation
	constant clk_hz : integer := 50e6; --f = 50 Mhz clock
	constant clk_period : time := 1 sec / clk_hz; --1/f = T = 20 ns period

	--DUT signals required
	SIGNAL tb_BCD0 : std_logic_vector(3 downto 0);
	SIGNAL tb_clock : std_logic := '1'; --DUT's clock input.
	SIGNAL tb_clear : std_logic := '1';
	SIGNAL tb_e0 : std_logic := '1';
	
	BEGIN
	
		DUT : BCDCount PORT MAP(tb_e0, tb_clear, tb_clock, tb_BCD0);

		tb_clock <= NOT tb_clock after clk_period / 2;
		tb_clear <= '0' after clk_period * 3 / 2; --clear loads 0 first, then release and count
		
END Behaviour;
