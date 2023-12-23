library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity delay is
    port (
        data_current : in integer;
        order : in integer;
        delay_in : in std_logic_vector (7 down to 0);
        delay_out : out std_logic
    );
end delay;

entity architecture rtl of delay is
    begin
        if data_current - order < 0 then
            delay_out <= 0;
        else 
            delay_out <= delay_in(data_current - order);
        end if;
end architecture rtl;


