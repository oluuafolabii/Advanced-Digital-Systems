library ieee;
use ieee.std_logic_1164.all;

-- Import library ieee and declare the entity LogicalOps
entity LogicalOps is
    port (
        ctrl: in std_logic_vector(3 downto 0); -- ctrl is a 4-bit signal input controlling the condition
        a: in std_logic; -- a is a 1-bit signal input
        b: in std_logic; -- b is a 1-bit signal input
        x: out std_logic -- x is a 1-bit signal output
    );
end LogicalOps;

architecture sel_arch of LogicalOps is -- Creating sel_arch using selected signal assignment statement
begin
    with ctrl select
        x <= a xor b when "1000" | "1001" | "1010" | "1011" |"1100" | "1101" | "1110" | "1111", -- a xor b when ctrl(3) = '1'
             a and b when "0100" | "0101" | "0110" | "0111", -- a and b when ctrl(2) = '1'
             a or b when "0010" | "0011",                    -- a or b when ctrl(1) = '1'
             not b when "0001",                              -- not b when only the lowest bit is '1'
             not a when others;                              -- default to not a for all other scenarios
end sel_arch;