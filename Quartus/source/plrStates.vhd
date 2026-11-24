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

ENTITY plrStates IS
PORT (nextState : in std_logic;
		BCDIn : in std_logic_vector(3 downto 0);
		hardReset : in std_logic;
		softReset : in std_logic;
		LED : out std_logic_vector(5 downto 0);
		running : out std_logic;
		currPLr : out std_logic_vector(1 downto 0);
		plr1 : out std_logic_vector(3 downto 0);
		plr2 : out std_logic_vector(3 downto 0));

END plrStates;

ARCHITECTURE logicFunc OF plrStates IS

TYPE State_type IS (S0, S1, S2, S3, S4, S5);
SIGNAL y : State_type ;

BEGIN

PROCESS (hardReset,softReset, nextState)
BEGIN
	IF hardReset = '1' THEN
		y <= S0;
		currPlr <= "01";
		plr1 <= "1111";
		plr2 <= "1111";
		LED(5 downto 1) <= "00000";
		LED(0) <= '1';
	ELSIF rising_edge(nextState) then
		CASE y IS
			WHEN S0 =>
				if softReset = '1' then
					y <= S0;
					currPlr <= "01";
					plr1 <= "1111";
					running <= '0';
					LED(5 downto 1) <= "00000";
					LED(0) <= '1';
				else
					y <= S1;
					currPlr <= "01";
					running <= '1';
					LED(0) <= '0';
					LED(1) <= '1';
				end if;
			WHEN S1 =>
				if softReset = '1' then
					y <= S0;
					currPlr <= "01";
					plr1 <= "1111";
					running <= '0';
					LED(5 downto 1) <= "00000";
					LED(0) <= '1';
				else
					y <= S2;
					currPlr <= "01";
					plr1 <= BCDIn;
					running <= '0';
					LED(1 downto 0) <= "00";
					LED(2) <= '1';
					
				end if;
			WHEN S2 =>
				if softReset = '1' then
					y <= S0;
					currPlr <= "01";
					plr1 <= "1111";
					running <= '0';
					LED(5 downto 1) <= "00000";
					LED(0) <= '1';
				else
					y <= S3;
					currPlr <= "10";
					running <= '0';
					LED(2 downto 0) <= "000";
					LED(3) <= '1';
				end if;
			WHEN S3 =>
				if softReset = '1' then
					y <= S3;
					currPlr <= "10";
					plr2 <= "1111";
					running <= '0';
					LED(2 downto 0) <= "000";
					LED(3) <= '1';
					LED(5 downto 4) <= "00";
				else
					y <= S4;
					currPlr <= "10";
					running <= '1';
					LED(3 downto 0) <= "0000";
					LED(4) <= '1';
				end if;
				
			WHEN S4 =>
				if softReset = '1' then
					y <= S3;
					currPlr <= "10";
					plr2 <= "1111";
					running <= '0';
					LED(2 downto 0) <= "000";
					LED(3) <= '1';
					LED(5 downto 4) <= "00";
				else
					y <= S5;
					currPlr <= "10";
					plr2 <= BCDIn;
					running <= '0';
					LED(4 downto 0) <= "00000";
					LED(5) <= '1';
				end if;
			WHEN S5 =>
				if softReset = '1' then
					y <= S3;
					currPlr <= "10";
					plr2 <= "1111";
					running <= '0';
					LED(2 downto 0) <= "000";
					LED(3) <= '1';
					LED(5 downto 4) <= "00";
				else
					y <= S0;
					currPlr <= "01";
					plr1 <= "1111";
					plr2 <= "1111";
					running <= '0';
					LED(5 downto 1) <= "00000";
					LED(0) <= '1';
				end if;
		END CASE ;
	END IF;
END PROCESS;

END logicFunc;