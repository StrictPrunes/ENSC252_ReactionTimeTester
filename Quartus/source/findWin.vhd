-- File: findWin.vhd
-- Group: 36
-- Authors: Gabriel Dryer, Jeromey Gong
-- Purpose: computes the winner when in the 6th state of the fsm
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY findWin IS
PORT (e : in std_logic;
		goal : in std_logic_vector(3 downto 0);
		plrOut1 : in std_logic_vector(3 downto 0);
		plrOut2 : in std_logic_vector(3 downto 0);
		win : out std_logic_vector(3 downto 0));

END findWin;

ARCHITECTURE logicFunc OF findWin IS
		signal temp1, temp2 : unsigned(3 downto 0);
BEGIN

temp1 <= unsigned(plrOut1) - unsigned(goal) when unsigned(plrOut1) >= unsigned(goal) else unsigned(goal) - unsigned(plrOut1);
temp2 <= unsigned(plrOut2) - unsigned(goal) when unsigned(plrOut2) >= unsigned(goal) else unsigned(goal) - unsigned(plrOut2);

process(temp1, temp2)
begin
if e = '1' then
	if temp1 < temp2 then
		win <= "0001";
	elsif temp2 < temp1 then
		win <= "0010";
	elsif temp1 = temp2 then
		win <= "1101";
	end if;
else
	win <= "1111";
end if;
end process;
END logicFunc;