-- This is the entity declaration for the Sample_Delay module.
-- It has four ports: data_current, order, delay_in, and delay_out.
-- data_current is an input integer representing the current data value.
-- order is an input integer representing the delay order.
-- delay_in is an input array_8 representing the delay line.
-- delay_out is an output std_logic_vector(7 downto 0) representing the delayed output.
        -- If the difference between data_current and order is less than 0,
        -- set delay_out to "00000000".
        -- Otherwise, assign delay_out with the value at delay_in[data_current - order].
        if (data_current - order < 0) then
            delay_out <= "00000000";
        else 
            delay_out <= delay_in((data_current - order));
        end if;
    end process;
end architecture rtl;
