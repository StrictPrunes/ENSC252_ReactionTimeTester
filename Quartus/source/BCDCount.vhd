-- File: BCDCount.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Binary Coded Decimal counter; Instantiates Count4.vhd
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY BCDCount IS
PORT (e0 : in std_logic;
		clear : in std_logic;
		clock : in std_logic;
		BCD0 : out std_logic_vector(3 downto 0));

END BCDCount;

ARCHITECTURE logicFunc OF BCDCount IS

COMPONENT Count4 IS
PORT (d : in std_logic_vector(3 downto 0);
		e : in std_logic;
		l : in std_logic;
		clock : in std_logic;
		q : out std_logic_vector(3 downto 0));

END COMPONENT;

signal tempBCD0 : std_logic_vector(3 downto 0) := "0000";

BEGIN

u1 : Count4 PORT MAP("0000", e0, clear OR (tempBCD0(0) AND tempBCD0(3)), clock, tempBCD0);

BCD0 <= tempBCD0;

END logicFunc;