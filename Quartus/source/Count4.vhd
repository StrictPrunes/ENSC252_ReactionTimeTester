-- File: Count4.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: 4 bit counter; increments on clock
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY Count4 IS
PORT (d : in std_logic_vector(3 downto 0);
		e : in std_logic;
		l : in std_logic;
		clock : in std_logic;
		q : out std_logic_vector(3 downto 0));

END Count4;

ARCHITECTURE logicFunc OF Count4 IS
signal tempQ : std_logic_vector(3 downto 0) := "0000";
BEGIN

process (clock, l)
begin
if (l = '1' AND rising_edge(clock)) then
 tempQ <= d;
elsif (l = '0' AND rising_edge(clock)) then
 tempQ(0) <= tempQ(0) XOR e;
 tempQ(1) <= tempQ(1) XOR (tempQ(0) AND e);
 tempQ(2) <= tempQ(2) XOR (tempQ(0) AND e AND tempQ(1));
 tempQ(3) <= tempQ(3) XOR (tempQ(0) AND e AND tempQ(1) AND tempQ(2));
end if;

end process;

q <= tempQ;

END logicFunc;