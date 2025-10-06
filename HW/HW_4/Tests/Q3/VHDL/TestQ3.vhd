library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity conditional_logic is
    Port (
        a      : in  unsigned(7 downto 0);   -- 8-bit input A
        b      : in  unsigned(7 downto 0);   -- 8-bit input B
        op     : in  std_logic_vector(1 downto 0); -- 2-bit operation selector
        y      : out unsigned(7 downto 0);   -- Output y (result of subtraction)
        z      : out unsigned(7 downto 0);   -- Output z (result of -1 from a or b)
        status : out std_logic               -- Status flag
    );
end conditional_logic;

architecture Behavioral of conditional_logic is
begin

    process(a, b, op)
    begin
        if (a > b and op = "00") then
            y <= a - b;
            z <= a - 1;
            status <= '0';
        else
            y <= b - a;
            z <= b - 1;
            status <= '1';
        end if;
    end process;

end Behavioral;