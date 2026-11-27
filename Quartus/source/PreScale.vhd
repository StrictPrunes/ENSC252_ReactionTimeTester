-- File: PreScale.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Increments a 23 bit number by increments depening on speed and outputs the most significant bit to slow down the clock speed
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY PreScale IS
PORT (clock : in std_logic;
		speed : in std_logic_vector(1 downto 0);
		f : out std_logic);

END PreScale;

ARCHITECTURE logicFunc OF PreScale IS
	 signal acc : unsigned(22 downto 0) := (others => '0');
BEGIN


process(clock, acc)
begin
	if rising_edge(clock) then
		if speed = "01" then
			acc <= acc + 1;
		elsif speed = "10" then
			acc <= acc + 2;
		elsif speed = "11" then
			acc <= acc + 3;
		end if;
	end if;
end process;

f <= std_logic(acc(22));

END logicFunc;