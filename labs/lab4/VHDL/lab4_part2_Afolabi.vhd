library IEEE;  -- Import IEEE standard logic libraries
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lab4_circuit is
    port (
        a1: in std_logic;                   -- 1-bit input a1
        a2: in std_logic;                   -- 1-bit input a2
        s: in std_logic_vector(1 downto 0); -- 2-bit selector s
        x: out std_logic                    -- 1-bit output x
    );
end lab4_circuit;

architecture rtl of lab4_circuit is
    signal not_a1: std_logic;  -- Signal for NOT gate output (NOT A1)
    signal or_out: std_logic;  -- Signal for OR gate output (A1 OR A2)
    signal and_out: std_logic; -- Signal for AND gate output (A1 AND A2)
begin
    -- NOT Gate Implementation (NOT A1)
    not_a1 <= not a1;

    -- OR and AND Gate Implementations
    or_out  <= a1 or a2;      -- A1 OR A2
    and_out <= a1 and a2;     -- A1 AND A2

    -- Selected Signal Assignment for Custom Logic Unit with MUX
    with s select
        x <= not_a1   when "00",  -- Output from NOT A1 when s = "00"
             a2       when "01",  -- Output A2 directly when s = "01"
             or_out   when "10",  -- Output from OR gate when s = "10"
             and_out  when "11",  -- Output from AND gate when s = "11"
             '0'      when others; -- Default case for safety

end rtl;
