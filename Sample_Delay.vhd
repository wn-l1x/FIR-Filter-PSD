library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.delay_pkg.all;

entity Sample_Delay is
    port (
        data_current : in integer;
        order : in integer;
        delay_in : in array_8;  
        delay_out : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of Sample_Delay is
    begin
        process(data_current, order, delay_in) 
        begin
        if (data_current - order < 0) then
            delay_out <= "00000000";
        else 
            delay_out <= delay_in((data_current - order));
        end if;
        end process;
end architecture rtl;


