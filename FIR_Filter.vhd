library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_Filter is
    port (
        clk : in std_logic;
        control_word : in std_logic_vector(7 downto 0);
    );
end FIR_Filter;

architecture rtl of FIR_Filter is
---port initialization---------------------------
    component Adder is
        port (
            input_num : in  integer;
            adder_in : in  std_logic_vector((input_num - 1) downto 0)(7 downto 0);
            adder_out : out std_logic_vector(7 downto 0)
        );
    end component Adder;

    component Amplifier is
        port(
            constant : in std_logic_vector(7 downto 0);
            amp_in : in std_logic_vector(7 downto 0);
            amp_out : out std_logic_vector(7 downto 0)
        );
    end component Amplifier;

    component Sample_Delay is
        port(
        data_current : in integer;
        order : in integer;
        delay_in : in std_logic_vector (7 down to 0);
        delay_out : out std_logic
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
            case state
            when FETCH_ORDER =>
                if rising_edge(clk) then
                    order <= to_integer(unsigned(control_word(7 downto 5)));
                    state <= INSTANTIATE;
                end if;

            when INSTANTIATE =>
                for (i = 0; i < order; i++) loop
                    coefficient_array(i) <= control_word(7 downto 0);
                end loop;
                
                gen_components : --generate amplifiers based on order
                    for i in 0 to order generate
                        if rising_edge(clk) then
                            amplifier : entity work.Amplifier
                                port map (
                                    constant => data_array(i),
                                    amp_in => data_word(15 downto 8),
                                    amp_out => data_word(15 downto 8)
                                );
                            sample_delay : entity work.Sample_Delay
                                port map (
                                    data_current => 0,
                                    order => i,
                                    delay_in => delay_in
                                );
                        end if;
                    end generate gen_amplifiers;

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
    

    



    

    

    
    