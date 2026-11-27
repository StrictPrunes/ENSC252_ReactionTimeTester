-- File: BCDWraparound_tb.vhd
-- Group: 36
-- Authors: Gabriel Dryer; Jeromey Gong; Joshua Po
-- Purpose: Verifies the BCD sequence counting, enable, clear, and 9-to-0 wraparound.
-- Responsibility: The named authors are responsible for this code
-- and can explain its design, implementation, and verification.
-- Adapted material: None
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCDWraparound_tb is
end BCDWraparound_tb;

architecture behavior of BCDWraparound_tb is

    component BCDCount is
        port (e0    : in std_logic;
              clear : in std_logic;
              clock : in std_logic;
              BCD0  : out std_logic_vector(3 downto 0));
    end component;

    signal clk : std_logic := '0';
    signal clr : std_logic := '0';
    signal en  : std_logic := '0';
    signal bcd : std_logic_vector(3 downto 0);
    constant clk_period : time := 20 ns;
begin
    UUT: BCDCount port map ( e0    => en,
							 clear => clr,
                             clock => clk,
                             BCD0  => bcd);
    -- clock generation
    clk_process : process
    begin
        clk <= not clk;
        wait for clk_period / 2;
    end process;
    -- test process
    test_process : process begin
        -- t1: clear counter
        clr <= '1';
        en <= '0';
        wait for clk_period * 2;
        clr <= '0';
        wait until rising_edge(clk);
        wait for 2 ns;
        assert bcd = "0000"
            report "Clear failed" severity error;
        -- t2: counter stays at 0 when disabled
        wait for clk_period * 5;
        assert bcd = "0000"
            report "Counter changed while disabled" severity error;
        -- t3: count from 1 to 9
        en <= '1';
        for i in 1 to 9 loop
            wait until rising_edge(clk);
            wait for 2 ns;
            assert to_integer(unsigned(bcd)) = i
                report "Incorrect counting sequence" severity error;
        end loop;
        -- t4: wrap from 9 back to 0
        wait until rising_edge(clk);
        wait for 2 ns;
        assert bcd = "0000"
            report "Wraparound failed" severity error;
        -- t5: count two more times
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait for 2 ns;
        assert bcd = "0010"
            report "Expected count of 2" severity error;
        -- t6: disable and check that count holds
        en <= '0';
        wait for clk_period * 5;
        assert bcd = "0010"
            report "Counter did not hold its value" severity error;
        -- enable and check next count
        en <= '1';
        wait until rising_edge(clk);
        wait for 2 ns;
        assert bcd = "0011"
            report "Counter did not advance to 3" severity error;
        -- t7: clear while counting
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        clr <= '1';
        wait for clk_period * 2;
        clr <= '0';
        wait for 2 ns;
        assert bcd = "0000"
            report "Mid-count clear failed" severity error;
        report "TEST PASSED: All BCD tests completed." severity note;
        wait;
    end process;

end architecture behavior;
