-- File: plrStates.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: handles fsm logic
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY plrStates IS
PORT (nextState : in std_logic;
		BCDIn : in std_logic_vector(3 downto 0);
		hardReset : in std_logic;
		softReset : in std_logic;
		LED : out std_logic_vector(7 downto 0);
		running : out std_logic;
		currPLr : out std_logic_vector(1 downto 0);
		plr1 : out std_logic_vector(3 downto 0);
		plr2 : out std_logic_vector(3 downto 0));

END plrStates;

ARCHITECTURE logicFunc OF plrStates IS

TYPE State_type IS (S0, S1, S2, S3, S4, S5, S6, S7);
SIGNAL y : State_type ;

BEGIN

PROCESS (hardReset,softReset, nextState)
BEGIN
	IF hardReset = '1' THEN
		y <= S0;
		currPlr <= "01";
		plr1 <= "1111";
		plr2 <= "1111";
		running <= '0';
		LED(7 downto 1) <= "0000000";
		LED(0) <= '1';
	ELSIF rising_edge(nextState) then
		CASE y IS
			WHEN S0 =>
				y <= S1;
				currPlr <= "01";
				plr1 <= "1111";
				plr2 <= "1111";
				running <= '0';
				LED(7 downto 2) <= "000000";
				LED(0) <= '0';
				LED(1) <= '1';
			WHEN S1 =>
				y <= S2;
				currPlr <= "01";
				running <= '1';
				LED(1) <= '0';
				LED(2) <= '1';

			WHEN S2 =>
				if softReset = '1' then
					y <= S1;
					currPlr <= "01";
					plr1 <= "1111";
					running <= '0';
					LED(7 downto 2) <= "000000";
					LED(1) <= '1';
				else
					y <= S3;
					currPlr <= "01";
					plr1 <= BCDIn;
					running <= '0';
					LED(2 downto 0) <= "000";
					LED(3) <= '1';
					
				end if;
			WHEN S3 =>
				if softReset = '1' then
					y <= S1;
					currPlr <= "01";
					plr1 <= "1111";
					running <= '0';
					LED(7 downto 2) <= "000000";
					LED(1) <= '1';
				else
					y <= S4;
					currPlr <= "10";
					running <= '0';
					LED(3 downto 0) <= "0000";
					LED(4) <= '1';
				end if;
			WHEN S4 =>
			
					y <= S5;
					currPlr <= "10";
					running <= '1';
					LED(4 downto 0) <= "00000";
					LED(5) <= '1';

				
			WHEN S5 =>
				if softReset = '1' then
					y <= S4;
					currPlr <= "10";
					plr2 <= "1111";
					running <= '0';
					LED(3 downto 0) <= "0000";
					LED(4) <= '1';
					LED(7 downto 5) <= "000";
				else
					y <= S6;
					currPlr <= "10";
					plr2 <= BCDIn;
					running <= '0';
					LED(5 downto 0) <= "000000";
					LED(6) <= '1';
				end if;
			WHEN S6 =>
				if softReset = '1' then
					y <= S4;
					currPlr <= "10";
					plr2 <= "1111";
					running <= '0';
					LED(3 downto 0) <= "0000";
					LED(4) <= '1';
					LED(7 downto 5) <= "000";
				else
					y <= S7;
					currPlr <= "10";
					
					running <= '0';
					LED(6 downto 0) <= "0000000";
					LED(7) <= '1';
				end if;
			WHEN S7 =>
				y <= S0;
				currPlr <= "01";
				plr1 <= "1111";
				plr2 <= "1111";
				running <= '0';
				LED(7 downto 1) <= "0000000";
				LED(0) <= '1';
		END CASE ;
	END IF;
END PROCESS;

END logicFunc;