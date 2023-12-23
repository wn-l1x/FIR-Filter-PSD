library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Amplifier is
    port (
        coefficient : in std_logic_vector(7 downto 0);
        amp_in : in std_logic_vector(7 downto 0);
        amp_out : out std_logic_vector(7 downto 0)
    );
end entity Amplifier;

architecture rtl of Amplifier is
    signal coefficient_real : real := 0.0;
    signal amp_in_real : real := 0.0;
    signal amp_out_real : real := 0.0;

begin
    coefficient_real <= real(to_integer(signed(coefficient))) / 128.0;
    amp_in_real <= real(to_integer(signed(amp_in)));
    amp_out_real <= amp_in_real * coefficient_real;
    amp_out <= std_logic_vector(to_signed(integer(amp_out_real), 8));
end architecture rtl;
