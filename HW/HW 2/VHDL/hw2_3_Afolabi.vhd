library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw2_3 is
    port (
        s: in std_logic_vector(1 downto 0);
        z: out std_logic
    );
end hw2_3;

architecture rtl of hw2_3 is
begin
    -- 2-to-1 MUX using selected signal assignment
    with s(0) select
        z <= '1' when '0',  -- If LSB of s is 0 (s = 00 or 10), output is 1
             '0' when others;  -- If LSB of s is 1 (s = 01 or 11), output is 0
end rtl;