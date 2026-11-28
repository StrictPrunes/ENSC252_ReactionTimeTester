-- File: winTie_tb.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Testbench for findWin.vhd; checks Player 1 win, Player 2 win, tie, no 9/0 wraparound, and blank result when e = 0
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY winTie_tb is
END winTie_tb;

ARCHITECTURE Behaviour of winTie_tb is

COMPONENT findWin IS --the component we would like to test
	PORT (   e : in std_logic;
		   goal : in std_logic_vector(3 downto 0);
		plrOut1 : in std_logic_vector(3 downto 0);
		plrOut2 : in std_logic_vector(3 downto 0);
		    win : out std_logic_vector(3 downto 0));
	END COMPONENT;

COMPONENT reactionStart IS
PORT (e : in std_logic;
		clock : in std_logic;
		running : in std_logic;
		plrOut : out std_logic_vector(3 downto 0));

END COMPONENT;
	--for clock generation
	constant clk_hz : integer := 50e6; --f = 50 Mhz clock
	constant clk_period : time := 1 sec / clk_hz; --1/f = T = 20 ns period
	
	--DUT signals required
	SIGNAL tb_e : std_logic := '1';
	SIGNAL tb_clock : std_logic := '1'; --DUT's clock input. Assign the clock a starting value for Modelsim
	SIGNAL tb_goal : std_logic_vector(3 downto 0) := "0001";
	SIGNAL tb_p1 : std_logic_vector(3 downto 0) := "0000";
	SIGNAL tb_p2 : std_logic_vector(3 downto 0) := "0000";
	SIGNAL tb_tempOut : std_logic_vector(3 downto 0) := "0000";
	SIGNAL tb_win : std_logic_vector(3 downto 0);
	
	BEGIN
	
		DUT : findWin PORT MAP(tb_e, tb_goal, tb_p1, tb_p2, tb_win);
		DUT_1 : reactionStart PORT Map(tb_e, tb_clock, '1', tb_tempOut);
		
		tb_clock <= NOT tb_clock after clk_period / 2;
		
		tb_p1 <= tb_tempOut after clk_period * 3;
		tb_p2 <= tb_tempOut after clk_period * 5;
		
END Behaviour;
