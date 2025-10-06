library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration
entity case_decoder is
    Port (
        s : in  std_logic_vector(1 downto 0); -- 2-bit input
        z : out std_logic                     -- 1-bit output
    );
end case_decoder;

-- Architecture using behavioral modeling and CASE statement
architecture Behavioral of case_decoder is
begin

    process(s)
    begin
        case s is
            when "00" =>
                z <= '0';
            when "01" =>
                z <= '1';
            when "10" =>
                z <= '0';
            when "11" =>
                z <= '1';
            when others =>
                z <= '0'; -- Safe default case
        end case;
    end process;

end Behavioral;