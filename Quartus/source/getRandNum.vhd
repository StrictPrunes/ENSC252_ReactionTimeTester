-- File: getRandNum.vhd
-- Group: 36
-- Authors: Gabriel Dryer
-- Purpose: Upcounter to latch a random number when enabled
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY getRandNum IS
PORT (e : in std_logic;
		clock : in std_logic;
		rand : out std_logic_vector(3 downto 0));

END getRandNum;

ARCHITECTURE logicFunc OF getRandNum IS
		signal temp : unsigned(3 downto 0);
BEGIN

process(e, clock, temp)
begin
	if e = '1' AND rising_edge(clock) AND temp = "1001" then
		temp <= "0000";
	elsif rising_edge(clock) AND e = '1' then
		temp <= temp +1;
	end if;
end process;

rand <= std_logic_vector(temp);

END logicFunc;