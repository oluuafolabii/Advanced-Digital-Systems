library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counters is
    Port (
        clk    : in std_logic;
        reset  : in std_logic;
        ctrl1  : in std_logic_vector(1 downto 0);
        ctrl2  : in std_logic_vector(1 downto 0);
        leds   : out std_logic_vector(1 downto 0)
    );
end Counters;

architecture rtl of Counters is
    signal cnter1_reg, cnter1_next : unsigned(29 downto 0);
    signal cnter2_reg, cnter2_next : unsigned(29 downto 0);
begin

    -- Process to define registers for Counter1 and Counter2
    process(clk, reset)
    begin
        if reset = '1' then
            cnter1_reg <= (others => '0');
            cnter2_reg <= (others => '0');
        elsif rising_edge(clk) then
            cnter1_reg <= cnter1_next;
            cnter2_reg <= cnter2_next;
        end if;
    end process;

    -- Next-state logic for Counter1 (selected signal assignment)
    with ctrl1 select
        cnter1_next <= cnter1_reg + 1 when "00",
                       cnter1_reg + 2 when "01",
                       cnter1_reg + 4 when "10",
                       cnter1_reg + 8 when others;

    -- Output logic for Counter1
    leds(0) <= cnter1_reg(29);

    -- Next-state logic for Counter2 (case statement inside a process)
    process(ctrl2, cnter2_reg)
    begin
        case ctrl2 is
            when "00" =>
                cnter2_next <= cnter2_reg + 1;
            when "01" =>
                cnter2_next <= cnter2_reg + 2;
            when "10" =>
                cnter2_next <= cnter2_reg + 4;
            when others =>
                cnter2_next <= cnter2_reg + 8;
        end case;
    end process;

    -- Output logic for Counter2
    leds(1) <= cnter2_reg(29);

end rtl;
