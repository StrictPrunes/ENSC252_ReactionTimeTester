-- File: BCDCount.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Binary Coded Decimal counter; Instantiates Count4.vhd
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bothResets_tb is
END bothResets_tb;

ARCHITECTURE Behaviour of bothResets_tb is
COMPONENT plrStates IS
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

	--for clock generation
	constant clk_hz : integer := 50e6; --f = 50 Mhz clock
	constant clk_period : time := 1 sec / clk_hz; --1/f = T = 20 ns period

	--DUT signals required
	SIGNAL tb_clock : std_logic := '1'; --DUT's clock input.
	SIGNAL tb_hardReset : std_logic := '1';
	SIGNAL tb_softReset : std_logic := '1';
	SIGNAL tb_state : std_logic_vector(7 downto 0) := "00000000"; -- shows what state system is on
	signal tb_running : std_logic := '0'; -- dont need to load
	signal tb_currPlr : std_logic_vector(1 downto 0) := "00"; -- dont need to load
	signal tb_plr1 : std_logic_vector(3 downto 0) := "0000"; -- dont need to load
	signal tb_plr2 : std_logic_vector(3 downto 0) := "0000"; -- dont need to load
	
	BEGIN
	
		DUT : plrStates
		PORT MAP("100", tb_clock, "0000", tb_hardReset, tb_softReset, tb_state, tb_running, tb_currPlr, tb_plr1, tb_plr2);

		--Simple assignment statement that inverts the clock ever clk_period/2 to create 
		--a constant clock signal for our simulations
		tb_clock <= NOT tb_clock after clk_period;
		tb_hardReset <= NOT tb_hardReset after clk_period * 10.25; -- .25, so it tests resets at and outside of clock edge
		tb_softReset <= NOT tb_softReset after clk_period * 10.25;
		
		

END Behaviour;
