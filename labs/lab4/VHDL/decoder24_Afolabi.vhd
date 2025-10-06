library IEEE;  -- Import the IEEE library for standard logic operations
use IEEE.STD_LOGIC_1164.ALL;  -- Using standard logic data types
use IEEE.NUMERIC_STD.ALL;     -- Using numeric operations for std_logic types

entity decoder24 is  -- Entity declaration to define inputs and outputs
    port (
        ctrl: in std_logic_vector(1 downto 0);  -- 2-bit input for control signals
        a: out std_logic_vector(3 downto 0)    -- 4-bit output representing one-hot code
    );
end decoder24;

architecture rtl of decoder24 is  -- Architecture declaration to implement logic
begin
    -- Selected Signal Assignment for 2-to-4 Decoder based on 'ctrl' input
    with ctrl select
        a <= "0001" when "00",  -- Set first bit to 1 when ctrl = 00
             "0010" when "01",  -- Set second bit to 1 when ctrl = 01
             "0100" when "10",  -- Set third bit to 1 when ctrl = 10
             "1000" when "11",  -- Set fourth bit to 1 when ctrl = 11
             "0000" when others; -- Default case (outputs all zero if input is invalid)

end rtl;  
