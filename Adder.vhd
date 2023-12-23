library ieee;
use ieee.std_logic_1164.all;

entity Adder is
    generic (
        input_num : integer;
    )
    port (
        adder_in : in  std_logic_vector((input_num - 1) downto 0)(7 downto 0);
        adder_out : out std_logic_vector(7 downto 0)
    );

end Adder;

architecture rtl of Adder is
    begin
        adder_out <= (others => '0');
        for i in 0 to input_num - 1 loop
            adder_out <= std_logic_vector(unsigned(output) + unsigned(inputs(i)));
        end loop;
    end rtl;
