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

ENTITY Fcount_tb is
END Fcount_tb;

ARCHITECTURE Behaviour of Fcount_tb is
COMPONENT Fcount IS --the component we would like to test
	PORT (clock, reset : in std_logic;
		D : in std_logic_vector(3 downto 0);
		f : out unsigned(5 downto 0));
	END COMPONENT;

	--for clock generation
	constant clk_hz : integer := 50e6; --f = 50 Mhz clock
	constant clk_period : time := 1 sec / clk_hz; --1/f = T = 20 ns period

	--DUT signals required
	SIGNAL tb_f : UNSIGNED(5 downto 0);
	SIGNAL tb_clock : std_logic := '1'; --DUT's clock input. Assign the clock a starting value for Modelsim
	SIGNAL tb_reset : std_logic := '1';
	SIGNAL tb_d : UNSIGNED(3 downto 0) := "0001";
	
	BEGIN
	
		DUT : Fcount
		PORT MAP(tb_clock, tb_reset, STD_LOGIC_VECTOR(tb_d), tb_f);

		--Simple assignment statement that inverts the clock ever clk_period/2 to create 
		--a constant clock signal for our simulations
		tb_clock <= NOT tb_clock after clk_period / 2;
		tb_reset <= NOT tb_reset after clk_period * 3;
		tb_d <= tb_d + 1 after clk_period * 3;
		
		

END Behaviour;