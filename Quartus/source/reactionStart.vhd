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

ENTITY reactionStart IS
PORT (e : in std_logic;
		clock : in std_logic;
		running : in std_logic;
		plrOut : out std_logic_vector(3 downto 0));

END reactionStart;

ARCHITECTURE logicFunc OF reactionStart IS
	
COMPONENT BCDCount IS
PORT (e0 : in std_logic;
		clear : in std_logic;
		clock : in std_logic;
		BCD0 : out std_logic_vector(3 downto 0));

END COMPONENT;

	 signal tempBCD : std_logic_vector(3 downto 0);
BEGIN


u2: BCDCount PORT MAP(running, not running, clock, tempBCD);
plrOut <= tempBCD;



END logicFunc;