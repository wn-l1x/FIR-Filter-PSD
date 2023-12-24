-- FILEPATH: /d:/Wendy/PSD/FIR_Filter_tb.vhd
library ieee;
use ieee.std_logic_1164.all;

entity FIR_Filter_tb is
end FIR_Filter_tb;

architecture tb_arch of FIR_Filter_tb is
    -- Component declaration
    component FIR_Filter is
        port (
            clk : in std_logic;
            control_word : in std_logic_vector(7 downto 0)
        );
    end component FIR_Filter;

    -- Signal declaration
    signal clk_tb : std_logic := '0';
    signal control_word_tb : std_logic_vector(7 downto 0) := (others => '0');

begin
    -- Instantiate the DUT (Device Under Test)
    uut: FIR_Filter port map (
        clk => clk_tb,
        control_word => control_word_tb
    );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        control_word_tb <= "11100000";
        wait for 10 ns;
        control_word_tb <= "00000001";
        wait for 10 ns;
        wait;
    end process;

end tb_arch;
