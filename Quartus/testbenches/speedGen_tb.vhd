-- File: speedGen_tb.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Testbench for getSpeed.vhd and PreScale.vhd; checks the three speed codes, invalid codes, e = 0, and Easy slower than Medium slower than Hard
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY speedGen_tb is
END speedGen_tb;

ARCHITECTURE Behaviour of speedGen_tb is
COMPONENT getSpeed IS --the components we would like to test
	PORT (       e : in std_logic;
		        ins : in std_logic_vector(2 downto 0);
      mkSelection : in std_logic;
		          f : out std_logic_vector(1 downto 0) := "01");
	END COMPONENT;

COMPONENT PreScale IS
	PORT (clock : in std_logic;
		   speed : in std_logic_vector(1 downto 0);
		       f : out std_logic);
	END COMPONENT;

	--for clock generation
	constant clk_hz : integer := 50e6; --f = 50 Mhz clock
	constant clk_period : time := 1 sec / clk_hz; --1/f = T = 20 ns period

	--DUT signals required
	SIGNAL tb_clock : std_logic := '1'; --DUT's clock input. Assign the clock a starting value for Modelsim
	SIGNAL tb_e : std_logic := '1';
	SIGNAL tb_ins : std_logic_vector(2 downto 0) := "001"; -- speed code
	SIGNAL tb_mk : std_logic := '0'; -- move speed code to 2 bit selection
	SIGNAL tb_f : std_logic_vector(1 downto 0); --speed selection to 2 bit code
	SIGNAL tb_speed : std_logic; --PreScale output for speed
	
	BEGIN
	
		DUT : getSpeed PORT MAP(tb_e,tb_ins , tb_mk, tb_f);
		DUT_E : PreScale PORT MAP(tb_clock, tb_f, tb_speed);

		tb_clock <= NOT tb_clock after clk_period;

	process(tb_ins)
		begin
			if tb_ins = "100" then
				tb_ins <= "001" after clk_period * 2;
			elsif tb_ins = "001" then
				tb_ins <= "010" after clk_period * 2;
			elsif tb_ins = "010" then
				tb_ins <= "100" after clk_period * 2;
			end if;
	end process;

		tb_mk <= NOT tb_mk after clk_period;


END Behaviour;
