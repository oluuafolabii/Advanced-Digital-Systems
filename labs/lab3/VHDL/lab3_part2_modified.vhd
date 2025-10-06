library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Index is
    Port (
        ctrl: in std_logic_vector(2 downto 0);  -- Expanded 'ctrl' from 2 bits to 3 bits to allow selecting any of 8 positions
        a: out std_logic_vector(7 downto 0)    -- Expanded 'a' from 4 bits to 8 bits to support 8 output LEDs
    );
end Index;

architecture rtl of Index is
    signal au: unsigned(7 downto 0);  -- Expanded 'au' from 4 bits to 8 bits to match the increased output width
begin
    process (au, ctrl)
    begin
        au <= (others => '1');  -- Changed initialization from '0' to '1' so that all bits start as '1' before modification
        au(to_integer(unsigned(ctrl))) <= '0';  -- Changed indexed assignment from '1' to '0' to invert the output behavior
        a <= std_logic_vector(au);  -- Converts 'au' from unsigned to std_logic_vector for proper output assignment
    end process;
end rtl;
