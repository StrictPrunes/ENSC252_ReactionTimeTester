-- Gabriel Dryer - 301652362; Jeromey Gong - 301656280; Joshua Po - 301639298
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY PreScale IS
PORT (clock : in std_logic;
		speed : in std_logic_vector(2 downto 0);
		f : out std_logic);

END PreScale;

ARCHITECTURE logicFunc OF PreScale IS
	 signal acc : unsigned(19 downto 0) := "00000000000000000000";
BEGIN


process(clock, acc)
begin
	if rising_edge(clock) then
		acc <= acc + 1;
	end if;
end process;

f <= std_logic(acc(19));

END logicFunc;