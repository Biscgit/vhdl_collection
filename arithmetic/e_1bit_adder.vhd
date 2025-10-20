library ieee;
use ieee.std_logic_1164.all;


entity e_1bit_adder is
    port (  bit1, bit2, carry_in  : in  std_logic;
            s, carry_out          : out std_logic);
end entity e_1bit_adder;

architecture e_1bit_adder of e_1bit_adder is
begin
    -- b a ci co s
    -- 0 0 0  0  0
    -- 0 0 1  0  1
    -- 0 1 0  0  1
    -- 0 1 1  1  0
    -- 1 0 0  0  1
    -- 1 0 1  1  0
    -- 1 1 0  1  0
    -- 1 1 1  1  1

    s <= (bit1 xor bit2 xor carry_in) or (bit1 and bit2 and carry_in);
    carry_out <= (bit1 and bit2) or (bit1 and carry_in) or (bit2 and carry_in);

end architecture e_1bit_adder;
