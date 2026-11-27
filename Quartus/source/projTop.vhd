-- File: projTop.vhd
-- Group: 36
-- Authors: Jeromey Gong; Gabriel Dryer; Joshua Po
-- Purpose: Top level; instantiates source files, maps to board, and displays to hexes
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY projTop IS
PORT (CLOCK_50 : in std_logic;
		KEY : in std_logic_vector(3 downto 0);
		SW : in std_logic_vector(9 downto 0);
		LEDR : out std_logic_vector(9 downto 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(6 downto 0) := "0000000");

END projTop;

ARCHITECTURE logicFunc OF projTop IS
COMPONENT PreScale IS
PORT (clock : in std_logic;
		speed : in std_logic_vector(1 downto 0);
		f : out std_logic);
END COMPONENT;

COMPONENT getSpeed IS
PORT (e : in std_logic;
		ins : in std_logic_vector(2 downto 0);
		mkSelection : in std_logic;
		f : out std_logic_vector(1 downto 0) := "00");

END COMPONENT;

COMPONENT reactionStart IS
PORT (e : in std_logic;
		clock : in std_logic;
		running : in std_logic;
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
		LED : out std_logic_vector(7 downto 0);
		running : out std_logic;
		currPLr : out std_logic_vector(1 downto 0);
		plr1 : out std_logic_vector(3 downto 0);
		plr2 : out std_logic_vector(3 downto 0));

END COMPONENT;

COMPONENT findWin IS
PORT (e : in std_logic;
		goal : in std_logic_vector(3 downto 0);
		plrOut1 : in std_logic_vector(3 downto 0);
		plrOut2 : in std_logic_vector(3 downto 0);
		win : out std_logic_vector(3 downto 0));

END COMPONENT;

COMPONENT getRandNum IS
PORT (e : in std_logic;
		clock : in std_logic;
		rand : out std_logic_vector(3 downto 0));

END COMPONENT;

signal clk, enable, startTest: std_logic := '0';
signal currentPlr : std_logic_vector(1 downto 0) := "00";
signal speed : std_logic_vector(1 downto 0) := "00";
signal tempPlrOut, plrOut1, plrOut2, randNum, win: std_logic_vector(3 downto 0) := "0000";
signal state : std_logic_vector(7 downto 0);

BEGIN


u6: getRandNum PORT MAP(state(0) OR SW(1), CLOCK_50, randNum);
u1: getSpeed PORT MAP(state(0), SW(9 downto 7), KEY(0), speed); --left 3 switches to select speed, left most key to save selection
u2: PreScale PORT MAP(CLOCK_50, speed, clk);
u3: plrStates PORT MAP(KEY(0), tempPlrOut, SW(1), SW(0), state, startTest, currentPlr, plrOut1, plrOut2); 
--KEY(0) proceeds to next state, SW(2) hard reset, SW(1) soft reset, current state displayed on leds
u4: reactionStart PORT MAP(enable, clk, startTest, tempPlrOut);
u5: findWin PORT MAP(state(7), randNum, plrOut1, plrOut2, win);

LEDR(7 downto 0) <= state;
LEDR(9 downto 8) <= speed;

mapHex0: SegDecoder PORT MAP(tempPlrOut, HEX0); --increasing number
mapHex1: SegDecoder PORT MAP(randNum, HEX1); --goal
mapHex3: SegDecoder PORT MAP(plrOut1, HEX3); --plr1 stopped num
mapHex2: SegDecoder PORT MAP(plrOut2, HEX2); --plr2 stopped num
mapHex4: SegDecoder PORT MAP(win, HEX4); --winning plr
mapHex5: SegDecoder PORT MAP("00" & currentPlr, HEX5); --current plr

END logicFunc;