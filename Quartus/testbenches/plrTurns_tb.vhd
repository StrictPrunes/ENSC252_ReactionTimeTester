-- File: plrTurns_tb.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Testbench for plrStates.vhd; walks both player turns S0 to S7 and back to S0, checks active player, running flag, result capture and retention, and that an invalid speed code blocks Start
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY plrTurns_tb is
END plrTurns_tb;

ARCHITECTURE Behaviour of plrTurns_tb is
COMPONENT plrStates IS --the component we would like to test
	PORT (e : in std_logic_vector(2 downto 0);
		nextState : in std_logic;
		BCDIn : in std_logic_vector(3 downto 0);
		hardReset : in std_logic;
		softReset : in std_logic;
		LED : out std_logic_vector(7 downto 0);
		running : out std_logic;
		currPLr : out std_logic_vector(1 downto 0);
		plr1 : out std_logic_vector(3 downto 0);
		plr2 : out std_logic_vector(3 downto 0));
	END COMPONENT;

	--DUT signals required
	SIGNAL tb_code : std_logic_vector(2 downto 0) := "011";
	SIGNAL tb_key : std_logic := '0'; --KEY(0)
	SIGNAL tb_digit : std_logic_vector(3 downto 0) := "0000"; 
	SIGNAL tb_hard : std_logic := '0';
	SIGNAL tb_soft : std_logic := '0';
	SIGNAL tb_state : std_logic_vector(7 downto 0);
	SIGNAL tb_running : std_logic;
	SIGNAL tb_curr : std_logic_vector(1 downto 0);
	SIGNAL tb_p1, tb_p2 : std_logic_vector(3 downto 0);
	
	BEGIN
	
		DUT : plrStates PORT MAP(tb_code, tb_key, tb_digit, tb_hard, tb_soft, tb_state, tb_running, tb_curr, tb_p1, tb_p2);

END Behaviour;
