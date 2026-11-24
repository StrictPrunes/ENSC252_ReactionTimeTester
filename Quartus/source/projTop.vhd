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

ENTITY projTop IS
PORT (CLOCK_50 : in std_logic;
		KEY : in std_logic_vector(3 downto 0);
		SW : in std_logic_vector(9 downto 0);
		LEDR : out std_logic_vector(9 downto 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(6 downto 0));

END projTop;

ARCHITECTURE logicFunc OF projTop IS
COMPONENT PreScale IS
PORT (clock : in std_logic;
		speed : in std_logic_vector(2 downto 0);
		f : out std_logic);
END COMPONENT;

COMPONENT getSpeed IS
PORT (e : in std_logic;
		ins : in std_logic_vector(2 downto 0);
		mkSelection : in std_logic;
		f : out std_logic_vector(2 downto 0) := "000");

END COMPONENT;

COMPONENT reactionStart IS
PORT (e : in std_logic;
		clock : in std_logic;
		plrIn : in std_logic;
		plrOut : out std_logic_vector(3 downto 0));

END COMPONENT;

COMPONENT SegDecoder IS
Port ( D : in std_logic_vector( 3 downto 0 ); 
		Y : out std_logic_vector( 6 downto 0 ) );
END COMPONENT;

COMPONENT plrStates IS
PORT (nextState : in std_logic;
		BCDIn : in std_logic_vector(3 downto 0);
		hardReset : in std_logic;
		softReset : in std_logic;
		LED : out std_logic_vector(5 downto 0);
		currPLr : out std_logic_vector(1 downto 0);
		plr1 : out std_logic_vector(3 downto 0);
		plr2 : out std_logic_vector(3 downto 0));

END COMPONENT;

TYPE State_type IS (SO, S1, S2, S3, S4, S5);
SIGNAL y : State_type ;
signal clk, start : std_logic := '0';
signal currentPlr : std_logic_vector(1 downto 0) := "00";
signal speed : std_logic_vector(2 downto 0) := "000";
signal tHEX0, plrOut1, plrOut2: std_logic_vector(3 downto 0) := "0000";
BEGIN

process(SW(9))
begin
	if SW(9) = '1' then
		start <= '1';
	else
		start <= '0';
	end if;
end process;

u1: getSpeed PORT MAP(not start, SW(2 downto 0), KEY(3), speed);
u2: PreScale PORT MAP(CLOCK_50, speed, clk);
u3: plrStates PORT MAP(KEY(0), tHEX0, SW(8), SW(7), LEDR(5 downto 0), currentPlr, plrOut1, plrOut2);
u4: reactionStart PORT MAP(start, clk, KEY(0), tHEX0);

mapHex0: SegDecoder PORT MAP(tHEX0, HEX0); --increasing number
--mapHex1: SegDecoder PORT MAP(randNum, HEX1); --goal
mapHex3: SegDecoder PORT MAP(plrOut1, HEX3); --plr1 stopped num
mapHex2: SegDecoder PORT MAP(plrOut1, HEX2); --plr2 stopped num
--mapHex4: SegDecoder PORT MAP(win, HEX4); --winning plr
mapHex5: SegDecoder PORT MAP("00" & currentPlr, HEX5); --current plr

--compareResults


END logicFunc;