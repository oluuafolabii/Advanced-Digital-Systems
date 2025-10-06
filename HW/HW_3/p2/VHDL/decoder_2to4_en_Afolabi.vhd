library ieee;
use ieee.std_logic_1164.all;

entity decoder_2to4en is
    port (
        en: in std_logic; -- Enable signal
        s: in std_logic_vector(1 downto 0); -- 2-bit input
        y: out std_logic_vector(3 downto 0) -- 4-bit output
    );
end decoder_2to4en;

architecture behavior of decoder_2to4en is
begin
    -- Conditional assignment statement for the 2-to-4 decoder
    y <= "0001" when (en = '1' and s = "00") else
         "0010" when (en = '1' and s = "01") else
         "0100" when (en = '1' and s = "10") else
         "1000" when (en = '1' and s = "11") else
         "0000"; -- Output is disabled when en = '0'
end behavior;
