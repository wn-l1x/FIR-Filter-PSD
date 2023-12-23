package delay_pkg is
    type array_8 is array (7 downto 0) of std_logic_vector(7 downto 0);
    procedure get_element(signal_array: in array_8; index: in integer; result: out std_logic_vector);
end package delay_pkg;
package body delay_pkg is
    procedure get_element(signal_array: in array_8; index: in integer; result: out std_logic_vector) is
    begin
        result <= signal_array(index);
    end procedure get_element;
end package body delay_pkg;
