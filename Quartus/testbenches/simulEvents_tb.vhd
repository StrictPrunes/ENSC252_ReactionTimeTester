-- File: simulEvents_tb.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Testbench for simultaneous events using plrStates.vhd and reactionStart.vhd; priority is Hard Reset > Soft Reset > Stop > sequence update
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY simulEvents_tb is
END simulEvents_tb;

ARCHITECTURE Behaviour of simulEvents_tb is
COMPONENT plrStates IS --the components we would like to test
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

COMPONENT reactionStart IS
	PORT (e : in std_logic;
		clock : in std_logic;
		running : in std_logic;
		plrOut : out std_logic_vector(3 downto 0));
	END COMPONENT;

	--for clock generation
	constant dig_period : time := 200 ns;

	--DUT signals required
	SIGNAL tb_clock : std_logic := '0';
	SIGNAL tb_key : std_logic := '0'; --KEY(0)
	SIGNAL tb_hard : std_logic := '0'; --Hard Reset
	SIGNAL tb_soft : std_logic := '0'; --Soft Reset
	SIGNAL tb_code : std_logic_vector(2 downto 0) := "001";
	SIGNAL tb_state : std_logic_vector(7 downto 0);
	SIGNAL tb_running : std_logic;
	SIGNAL tb_curr : std_logic_vector(1 downto 0);
	SIGNAL tb_digit, tb_p1, tb_p2 : std_logic_vector(3 downto 0);
	
	BEGIN
	
		DUT : plrStates PORT MAP(tb_code, tb_key, tb_digit, tb_hard, tb_soft, tb_state, tb_running, tb_curr, tb_p1, tb_p2);
		DUT2 : reactionStart PORT MAP('1', tb_clock, tb_running, tb_digit);

		tb_clock <= NOT tb_clock after dig_period / 2;

END Behaviour;
