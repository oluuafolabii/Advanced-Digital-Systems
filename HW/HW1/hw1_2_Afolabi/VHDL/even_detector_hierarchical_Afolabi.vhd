library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity even_detector is
    port(
        a: in std_logic_vector(2 downto 0);
        even: out std_logic
    );
end even_detector;

architecture str_arch of even_detector is

    component xor2 -- Declaration for XOR gate
        port(
            i1, i2: in std_logic;
            o1: out std_logic
        );
    end component;

    component not1 -- Declaration for inverter
        port(
            i1: in std_logic;
            o1: out std_logic
        );
    end component;

    signal sig1, sig2: std_logic;

begin
    -- Instantiation of the 1st XOR instance
    unit1: xor2
        port map (i1 => a(0), i2 => a(1), o1 => sig1);

    -- Instantiation of the 2nd XOR instance
    unit2: xor2
        port map (i1 => sig1, i2 => a(2), o1 => sig2);

    -- Instantiation of the NOT gate
    unit3: not1
        port map (i1 => sig2, o1 => even);

end str_arch;
