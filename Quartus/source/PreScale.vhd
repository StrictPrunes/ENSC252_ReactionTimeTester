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
	 signal acc : unsigned(22 downto 0) := (others => '0');
BEGIN


process(clock, acc)
begin
	if rising_edge(clock) then
		if speed = "001" then
			acc <= acc + 1;
		elsif speed = "010" then
			acc <= acc + 2;
		elsif speed = "100" then
			acc <= acc + 3;
		end if;
	end if;
end process;

f <= std_logic(acc(22));

END logicFunc;