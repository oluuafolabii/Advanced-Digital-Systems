library ieee;
use ieee.std_logic_1164.all;
-- Import library ieee and declare the entity LogicalOps
entity LogicalOps is
    port (
        ctrl: in std_logic_vector(3 downto 0); -- ctrl is a 4 bit signal input controlling the condition
        a: in std_logic; -- a is a 1 bit signal input
        b: in std_logic; -- b is 1 4 bit signal input
        x: out std_logic -- x is a 1 bit signal output
    );
end LogicalOps;

architecture cond_arch of LogicalOps is -- Creating cond_arch that should function like a priority encoder
begin
    x <= a xor b when (ctrl(3) = '1') else -- a xor b is outputted to x when the index 3 of ctrl is 1. If ctrl(3) = '1', x is set to a xor b. Evaluation stops here.
         a and b when (ctrl(2) = '1') else -- a and b is outputted to x when the index 2 of ctrl is 1. If ctrl(3) = '0' but ctrl(2) = '1', x is set to a and b.
         a or b when (ctrl(1) = '1') else -- a or b is outputted to x when the 1st index of ctrl is 1. If neither of the above, but ctrl(1) = '1', x is set to a or b.
         not b when (ctrl(0) = '1') else -- a not b is outputted to x when the lowest index of ctrl is 1. If none of the above, but ctrl(0) = '1', x is set to not b.
         not a; -- not a is outputted for all other scenarios such as 0000. If none of the conditions are met (ctrl = "0000"), x is set to not a.
end cond_arch;