-- File: BCDCount.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Binary Coded Decimal counter; Instantiates Count4.vhd
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;

entity speedGen_tb is
end speedGen_tb;

architecture behavior of speedGen_tb is

    component getSpeed is
        port ( e           : in std_logic;
               ins         : in std_logic_vector(2 downto 0);
               mkSelection : in std_logic;
               f           : out std_logic_vector(1 downto 0));
    end component;

    signal en       : std_logic := '1';
    signal switches : std_logic_vector(2 downto 0) := "000";
    signal mkSel    : std_logic := '0';
    signal f_out    : std_logic_vector(1 downto 0);

    constant EASY   : std_logic_vector(1 downto 0) := "01";
    constant MEDIUM : std_logic_vector(1 downto 0) := "10";
    constant HARD   : std_logic_vector(1 downto 0) := "11";

begin

    UUT: getSpeed
        port map ( e           => en,
                   ins         => switches,
                   mkSelection => mkSel,
                   f           => f_out);

    test_process : process
    begin

        -- t1: Easy speed
        switches <= "001";
        mkSel <= '0';
        wait for 10 ns;
        mkSel <= '1';
        wait for 10 ns;

        assert f_out = EASY
            report "Easy selection failed" severity error;

        -- t2: Medium speed
        switches <= "010";
        mkSel <= '0';
        wait for 10 ns;
        mkSel <= '1';
        wait for 10 ns;

        assert f_out = MEDIUM
            report "Medium selection failed" severity error;

        -- t3: Hard speed
        switches <= "100";
        mkSel <= '0';
        wait for 10 ns;
        mkSel <= '1';
        wait for 10 ns;

        assert f_out = HARD
            report "Hard selection failed" severity error;

        -- t4: Output should hold when selection is inactive
        mkSel <= '0';
        switches <= "001";
        wait for 20 ns;

        assert f_out = HARD
            report "Output changed while selection was inactive" severity error;

        -- t5: Output should hold when disabled
        en <= '0';
        switches <= "010";
        mkSel <= '0';
        wait for 10 ns;
        mkSel <= '1';
        wait for 10 ns;

        assert f_out = HARD
            report "Output changed while disabled" severity error;

        report "TEST PASSED: All speedGen tests completed."
            severity note;

        wait;
    end process;

end architecture behavior;
