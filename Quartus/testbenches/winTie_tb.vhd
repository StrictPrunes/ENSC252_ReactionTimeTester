-- File: winTie_tb.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Verifies the combinational scoring logic and winner/tie determination.
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity winTie_tb is
end winTie_tb;

architecture behavior of winTie_tb is

    component findWin is port ( e       : in std_logic;
										  goal    : in std_logic_vector(3 downto 0);
                                plrOut1 : in std_logic_vector(3 downto 0);
                                plrOut2 : in std_logic_vector(3 downto 0);
                                win     : out std_logic_vector(3 downto 0));
    end component;
    signal en   : std_logic := '0';
    signal goal : std_logic_vector(3 downto 0) := "0000";
    signal p1   : std_logic_vector(3 downto 0) := "0000";
    signal p2   : std_logic_vector(3 downto 0) := "0000";
    signal win  : std_logic_vector(3 downto 0);

    constant W1 : std_logic_vector(3 downto 0) := "0001";
    constant W2 : std_logic_vector(3 downto 0) := "0010";
    constant WT : std_logic_vector(3 downto 0) := "1101";
    constant WD : std_logic_vector(3 downto 0) := "1111";

begin
    UUT: findWin
        port map ( e       => en,
                   goal    => goal,
                   plrOut1 => p1,
                   plrOut2 => p2,
                   win     => win);
    test_process : process
    begin
        -- t1: disabled
        en <= '0';
        goal <= "0101";
        p1 <= "0101";
        p2 <= "0011";
        wait for 10 ns;
        assert win = WD
            report "Disabled test failed" severity error;
        en <= '1';
        -- t2: player 1 wins
        goal <= "0101";
        p1 <= "0101";
        p2 <= "0011";
        wait for 10 ns;
        assert win = W1
            report "Player 1 win test failed" severity error;
        -- t3: player 2 wins
        goal <= "0101";
        p1 <= "0011";
        p2 <= "0101";
        wait for 10 ns;
        assert win = W2
            report "Player 2 win test failed" severity error;
        -- t4: Equal distance tie
        goal <= "0101";
        p1 <= "0100";
        p2 <= "0110";
        wait for 10 ns;
        assert win = WT
            report "Equal distance tie test failed" severity error;
        -- t5: both players reach the goal
        goal <= "0101";
        p1 <= "0101";
        p2 <= "0101";
        wait for 10 ns;
        assert win = WT
            report "Both exact tie test failed" severity error;
        -- t6: player 1 wins
        goal <= "0111";
        p1 <= "0111";
        p2 <= "0000";
        wait for 10 ns;
        assert win = W1
            report "Player 1 win test failed" severity error;
        -- t7: Swap player scores
        goal <= "0100";
        p1 <= "0100";
        p2 <= "0101";
        wait for 10 ns;
        assert win = W1
            report "First swap test failed" severity error;
        p1 <= "0101";
        p2 <= "0100";
        wait for 10 ns;
        assert win = W2
            report "Second swap test failed" severity error;
        report "TEST PASSED: All winTie tests completed."
            severity note;
        wait;
    end process;

end architecture behavior;
