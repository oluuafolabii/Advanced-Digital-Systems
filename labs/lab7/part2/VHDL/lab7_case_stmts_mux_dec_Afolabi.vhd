library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity case_stmt_mux_dec is
    port (
        -- Select signal for both MUX and decoder
        s: in std_logic_vector(1 downto 0);

        -- Data inputs for 4-to-1 MUX
        a, b, c, d: in std_logic;

        -- Output of 4-to-1 MUX
        x: out std_logic;

        -- Output of 2-to-4 decoder
        y: out std_logic_vector(3 downto 0)
    );
end case_stmt_mux_dec;

architecture rtl of case_stmt_mux_dec is
begin

    -- Implement the 4-to-1 MUX using case statement
    process(s, a, b, c, d)
    begin
        case s is
            when "00" =>
                x <= a;  -- Select input a
            when "01" =>
                x <= b;  -- Select input b
            when "10" =>
                x <= c;  -- Select input c
            when "11" =>
                x <= d;  -- Select input d
            when others =>
                x <= '0';  -- Default safety output
        end case;
    end process;

    -- Implement the 2-to-4 decoder using case statement
    process(s)
    begin
        case s is
            when "00" =>
                y <= "0001";  -- Activate bit 0
            when "01" =>
                y <= "0010";  -- Activate bit 1
            when "10" =>
                y <= "0100";  -- Activate bit 2
            when "11" =>
                y <= "1000";  -- Activate bit 3
            when others =>
                y <= "0000";  -- Default to all zeros
        end case;
    end process;

end rtl;
