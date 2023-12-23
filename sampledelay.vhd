library ieee;
use ieee.std_logic_1164.all;

entity delay is
    port (
        clk: in std_logic;
        data_current : integer;
        data_in : in std_logic_vector (7 down to 0);
        data_out : out std_logic
    );
end delay;

entity architecture rtl of delay is
    begin
        if integer = 0 then
            data_out <= 0;
        else 
            data_out <= data_in(integer - 1);
        end if;
end architecture rtl;


