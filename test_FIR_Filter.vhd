-- FILEPATH: /d:/Wendy/PSD/FIR_Filter_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.delay_pkg.all;
library std;
use std.textio.all;
use std.standard.all;

entity FIR_Filter_tb is
end FIR_Filter_tb;

architecture tb_arch of FIR_Filter_tb is

    -- Constants
    constant CLK_PERIOD : time := 10 ns;
    constant DATA_WIDTH : integer := 8;
    constant COEFFICIENTS : std_logic_vector(DATA_WIDTH-1 downto 0) := "11001100";
    constant ORDER : integer := 8;
    
    -- Signals
    signal clk : std_logic := '0';
    signal control_word : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal filtered : real;
    
    -- Component instantiation
    component FIR_Filter is
        port (
            clk : in std_logic;
            control_word : in std_logic_vector(DATA_WIDTH-1 downto 0);
            filtered : out real
        );
    end component FIR_Filter;
    
    -- Clock process
    process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    process
    begin
        -- Initialize control_word
        control_word <= (others => '0');
        
        -- Apply input data
        for i in 0 to ORDER-1 loop
            control_word <= std_logic_vector(to_unsigned(i, DATA_WIDTH));
            wait for CLK_PERIOD;
        end loop;
        
        -- Wait for output to stabilize
        wait for CLK_PERIOD;
        
        -- Print filtered output
        report "Filtered output: " & real'image(filtered);
        
        -- End simulation
        wait;
    end process;
    
    -- DUT instantiation
    signal dut_filtered : real;
    begin
        DUT: FIR_Filter
        port map (
            clk => clk,
            control_word => control_word,
            filtered => dut_filtered
        );
        
        -- Assign DUT output to testbench signal
        filtered <= dut_filtered;
        
    end tb_arch;