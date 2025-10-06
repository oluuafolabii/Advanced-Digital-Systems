library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity selected_stmt_mux_dec is
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
end selected_stmt_mux_dec;

architecture rtl of selected_stmt_mux_dec is
begin

    -- Implement the 4-to-1 MUX using selected signal assignment
    with s select
        x <= a when "00",   -- Select input a when s = "00"
             b when "01",   -- Select input b when s = "01"
             c when "10",   -- Select input c when s = "10"
             d when "11",   -- Select input d when s = "11"
             '0' when others; -- Default to 0 for safety

    -- Implement the 2-to-4 decoder using selected signal assignment
    with s select
        y <= "0001" when "00",  -- Set y(0) when s = "00"
             "0010" when "01",  -- Set y(1) when s = "01"
             "0100" when "10",  -- Set y(2) when s = "10"
             "1000" when "11",  -- Set y(3) when s = "11"
             "0000" when others;  -- Default to all 0s for invalid inputs

end rtl;
