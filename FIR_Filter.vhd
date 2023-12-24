-- FILEPATH: /d:/Wendy/PSD/FIR_Filter.vhd
-- Entity declaration for FIR_Filter module
entity FIR_Filter is
    port (
        clk : in std_logic; -- Clock input
        control_word : in std_logic_vector(7 downto 0) -- Control word input
    );
end FIR_Filter;

architecture rtl of FIR_Filter is

    -- Function to convert std_logic_vector to real
    function real_convert (x : std_logic_vector) return real is
        variable temp : real;
    begin
        temp := real(to_integer(signed(x)));
        return temp;
    end function real_convert;
    
    -- File declarations for input and output values
    file delay_in_file : text open write_mode is "delay_in_values.txt"; -- File to store delay input values
    file adder_out_file : text open write_mode is "adder_out_values.txt"; -- File to store adder output values

    -- Component declarations
    component Adder is
        port (
            adder_in : in array_8; -- Input to the adder component
            adder_out : out std_logic_vector(7 downto 0) -- Output from the adder component
        );
    end component Adder;

    component Amplifier is
        port(
            coefficient : in std_logic_vector(7 downto 0); -- Coefficient input to the amplifier component
            amp_in : in std_logic_vector(7 downto 0); -- Input to the amplifier component
            amp_out : out std_logic_vector(7 downto 0) -- Output from the amplifier component
        );
    end component Amplifier;

    component Sample_Delay is
        port(
        data_current : in integer; -- Current data index
        order : in integer; -- Order of the filter
        delay_in : in array_8; -- Input to the delay component
        delay_out : out std_logic_vector(7 downto 0) -- Output from the delay component
        );
    end component Sample_Delay;

    -- Signal declarations
    type state_list is (FETCH_ORDER, FETCH_INPUT, FETCH_AMP, COUNT, ADD, DONE); -- State enumeration
    signal state : state_list := FETCH_ORDER; -- Current state
    signal order : integer; -- Order of the filter
    signal data_c : integer := 0; -- Current data index
    signal s_delay_in : array_8; -- Delay input signal
    signal s_delay_out : array_8; -- Delay output signal
    signal s_coefficient_list : array_8; -- Coefficient list signal
    signal s_amp_in : array_8; -- Amplifier input signal
    signal s_amp_out : array_8; -- Amplifier output signal
    signal s_adder_in : array_8; -- Adder input signal
    signal s_adder_out : std_logic_vector(7 downto 0); -- Adder output signal
    
begin
    -- Component generation
    amp_delay: for i in 0 to 7 generate
        gen_delay: Sample_Delay port map(
            data_current => data_c, -- Current data index
            order => i, -- Order of the filter
            delay_in => s_delay_in, -- Delay input signal
            delay_out => s_delay_out(i) -- Delay output signal
        );
        gen_amp: Amplifier port map(
            coefficient => s_coefficient_list(i), -- Coefficient input signal
            amp_in => s_amp_in(i), -- Amplifier input signal
            amp_out => s_amp_out(i) -- Amplifier output signal
        );
    end generate;

    gen_adder: Adder port map(
        adder_in => s_adder_in, -- Adder input signal
        adder_out => s_adder_out -- Adder output signal
    );

    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when FETCH_ORDER=>
                    order <= to_integer(unsigned(control_word(7 downto 5))); -- Extract order from control word
                    state <= FETCH_INPUT;

                when FETCH_INPUT=>
                    if rising_edge(clk) then
                        s_delay_in(data_c) <= control_word(7 downto 0); -- Store input data in delay input signal
                        data_c <= data_c + 1; -- Increment data index
                    end if;
                    if data_c = order then 
                        data_c <= 0;
                        state <= FETCH_AMP;
                    end if;

                when FETCH_AMP =>
                    if rising_edge(clk) then
                        s_coefficient_list(data_c) <= control_word(7 downto 0); -- Store coefficient in coefficient list signal
                        data_c <= data_c + 1; -- Increment data index
                    end if;
                    if data_c = order then 
                        data_c <= 0;
                        state <= COUNT;
                    end if;

                when COUNT =>
                    if rising_edge(clk) then
                        for i in 0 to 7 loop
                            s_amp_in(i) <= s_delay_out(i); -- Assign delay output to amplifier input
                        end loop;
                    end if;
                    state <= ADD;
                    
                when ADD =>   
                    for i in 0 to 7 loop
                        s_adder_in(i) <= s_amp_out(i); -- Assign amplifier output to adder input
                        write(delay_in_file, real'image(real(to_integer(signed(s_delay_in(i)))))); -- Write delay input value to file
                        write(delay_in_file, " ");
                        write(adder_out_file, real'image(real(to_integer(signed(s_adder_out))))); -- Write adder output value to file
                        write(adder_out_file, " ");
                    end loop;

                    if data_c = order+1 then 
                        data_c <= 0;
                        state <= DONE;
                    else
                        data_c <= data_c + 1;
                        state <= COUNT;
                    end if;

                when DONE =>
                    data_c <= 0;

            end case;
        end if;
    end process;

end architecture rtl;
