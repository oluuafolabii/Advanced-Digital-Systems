library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    -- Standard logic data types
use IEEE.NUMERIC_STD.ALL;       -- (Optional) For numeric operations

-- Entity Declaration
entity priority_encoder_if is
    Port (
        r      : in  std_logic_vector(3 downto 0);  -- 4-bit input vector
        code   : out std_logic_vector(1 downto 0);  -- 2-bit encoded output
        active : out std_logic                      -- Flag to indicate input activity
    );
end priority_encoder_if;

-- Architecture Definition
architecture Behavioral of priority_encoder_if is
begin

    -- Combinational process block that reacts to any change in input 'r'
    process (r)
    begin
        -- Check from highest priority bit to lowest
        if (r(3) = '1') then                -- Highest priority input
            code   <= "11";                -- Output code for r(3)
            active <= '1';                 -- Set active since input is high
        elsif (r(2) = '1') then            -- Next highest priority
            code   <= "10";                -- Output code for r(2)
            active <= '1';                 
        elsif (r(1) = '1') then            -- Next
            code   <= "01";                -- Output code for r(1)
            active <= '1';
        elsif (r(0) = '1') then            -- Lowest priority input
            code   <= "00";                -- Output code for r(0)
            active <= '1';
        else
            code   <= "00";                -- Default code when no input is high
            active <= '0';                 -- No input is active
        end if;
    end process;

end Behavioral;