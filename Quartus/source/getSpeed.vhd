-- File: reaction_timer_fsm.vhd
-- Group: XX
-- Authors: [names of members who wrote this file]
-- Purpose: [brief summary of this module or testbench]
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: [source and extent, or None]
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY getSpeed IS
PORT (e : in std_logic;
		ins : in std_logic_vector(2 downto 0);
		mkSelection : in std_logic;
		f : out std_logic_vector(2 downto 0) := "000");

END getSpeed;

ARCHITECTURE logicFunc OF getSpeed IS
	 
BEGIN

process (mkSelection)
begin
if (rising_edge(mkSelection) AND (ins = "001" OR ins = "010" OR ins = "100") AND e = '1') then
	f <= ins;
end if;

end process;



END logicFunc;