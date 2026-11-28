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

	--DUT signals required
	SIGNAL tb_e : std_logic := '0';
	SIGNAL tb_goal : std_logic_vector(3 downto 0) := "0000";
	SIGNAL tb_p1 : std_logic_vector(3 downto 0) := "0000";
	SIGNAL tb_p2 : std_logic_vector(3 downto 0) := "0000";
	SIGNAL tb_win : std_logic_vector(3 downto 0);
	
	BEGIN
	
		DUT : findWin PORT MAP(tb_e, tb_goal, tb_p1, tb_p2, tb_win);
		
END Behaviour;
