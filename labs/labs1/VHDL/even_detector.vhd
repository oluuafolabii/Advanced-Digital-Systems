library ieee;
use ieee.std_logic_1164.all;

entity even_detector is
    port(
        a: in std_logic_vector(2 downto 0);
        even: out std_logic
    );
end even_detector;

architecture arch of even_detector is
    signal p1, p2, p3, p4: std_logic;
begin
    even <= (p1 OR p2) OR (p3 OR p4);

    p1 <= (not a(2)) AND (not a(1)) AND (not a(0));
    p2 <= (not a(2)) AND a(1) AND a(0);
    p3 <= a(2) AND (not a(1)) AND a(0);
    p4 <= a(2) AND a(1) AND (not a(0));

end arch;
