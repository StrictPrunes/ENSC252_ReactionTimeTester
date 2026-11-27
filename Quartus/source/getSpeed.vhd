-- File: getSpeed.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: gets the speed on valid input
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY getSpeed IS
PORT (e : in std_logic;
		ins : in std_logic_vector(2 downto 0);
		mkSelection : in std_logic;
		f : out std_logic_vector(1 downto 0) := "01");

END getSpeed;

ARCHITECTURE logicFunc OF getSpeed IS
	 
BEGIN

process (mkSelection, e, ins)
begin
if (rising_edge(mkSelection) AND e = '1') then
	if ins = "001" then
		f <= "01";
	elsif ins = "010" then
		f <= "10";
	elsif ins = "100" then
		f <= "11";
	end if;
end if;

end process;



END logicFunc;