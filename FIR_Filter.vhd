library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.delay_pkg.all;

entity FIR_Filter is
    port (
        clk : in std_logic;
        control_word : in std_logic_vector(7 downto 0)
    );
end FIR_Filter;

architecture rtl of FIR_Filter is
    
---port initialization---------------------------
    component Adder is
        port (
            adder_in : array_8:= (others => (others => '0'));
            adder_out : out std_logic_vector(7 downto 0)
        );
    end component Adder;

    component Amplifier is
        port(
            data_current : in integer;
            order : in integer;
            delay_in : in array_8;  
            delay_out : out std_logic_vector(7 downto 0)
        );
    end component Amplifier;

    component Sample_Delay is
        port(
        data_current : in integer;
        order : in integer;
        delay_in : in array_8;  
        delay_out : out std_logic_vector(7 downto 0)
        );
    end component Sample_Delay;

---signal initialization-------------------------
    signal order : integer;
    type state_list is (FETCH_ORDER, INSTANTIATE, FETCH_NUM, COUNT, DONE);
    signal state : state_list := FETCH_ORDER;
    type data_array is array (0 to 7) of std_logic_vector(7 downto 0);
    signal coefficient_array : data_array;
    signal s_amp_in : data_array;
    signal s_amp_out : data_array;
    signal s_delay_in : data_array;
    signal s_delay_out : data_array;
    signal s_adder_in : data_array;
    signal s_adder_out : data_array;
    
    begin
        process (clk) is
            begin
            case state is
            when FETCH_ORDER =>
                if rising_edge(clk) then
                    order <= to_integer(unsigned(control_word(7 downto 5)));
                    state <= INSTANTIATE;
                end if;
            end case;
            end process;

            process (clk) is
                begin
                    for i in 0 to order generate
    
                        if rising_edge(clk) then
                            coefficient_array(i) <= control_word(7 downto 0);
                            amplifier : entity work.Amplifier
                                port map (
                                    constant => data_array(i),
                                    amp_in => control_word(7 downto 0)
                                );
                            sample_delay : entity work.Sample_Delay
                                port map (
                                    data_current => 0,
                                    order => i,
                                    delay_in => s_delay_out(i),
                                    delay_out => s_delay_in(i)
                                );
                        end if;
                    end generate;

                Adder port map (
                    input_num => order,
                    adder_in => data_word(15 downto 8),
                    adder_out => data_word(7 downto 0)
                );
                state <= COUNT;
        end case state;
            end process;

        process (clk) is
            begin
            case state
            when COUNT =>
                
            end case state;
            end process;

end rtl;
    

    



    

    

    
    