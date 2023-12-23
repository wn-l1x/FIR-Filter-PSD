library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.delay_pkg.all;

entity Adder is
    port (
        adder_in : array_8:= (others => (others => '0'));
        adder_out : out std_logic_vector(7 downto 0)
    );

end Adder;

architecture rtl of Adder is

    function real_convert (x : std_logic_vector) return real is
        variable temp : real;
    begin
        temp := real(to_integer(signed(x)));
        return temp;
    end function real_convert;

    signal a_out : real := 0.0;

begin
    a_out <= (real_convert(adder_in(0))/128.0) + (real_convert(adder_in(1))/128.0)
    + (real_convert(adder_in(2))/128.0) + (real_convert(adder_in(3))/128.0)
    + (real_convert(adder_in(4))/128.0) + (real_convert(adder_in(5))/128.0)
    + real_convert(adder_in(6))/128.0 + real_convert(adder_in(7))/128.0;
    adder_out <= std_logic_vector(to_signed(integer(a_out), 8));
end rtl;
