library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity nested_if_max is
    Port (
        a   : in  std_logic_vector(1 downto 0);
        b   : in  std_logic_vector(1 downto 0);
        c   : in  std_logic_vector(1 downto 0);
        max : out std_logic_vector(1 downto 0)
    );
end nested_if_max;
architecture Behavioral of nested_if_max is
    signal ua, ub, uc, umax : unsigned(1 downto 0);
begin

    -- Convert std_logic_vector inputs to unsigned
    ua <= unsigned(a);
    ub <= unsigned(b);
    uc <= unsigned(c);

    -- Process block using nested if statements to find the maximum
    process(ua, ub, uc)
    begin
        if ua > ub then
            if ua > uc then
                umax <= ua;
            else
                umax <= uc;
            end if;
        else
            if ub > uc then
                umax <= ub;
            else
                umax <= uc;
            end if;
        end if;
    end process;
    -- Assign the final maximum value to output, converting it back to std_logic_vector
    max <= std_logic_vector(umax);
end Behavioral;
