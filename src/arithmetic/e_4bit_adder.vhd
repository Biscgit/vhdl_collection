library ieee;
use ieee.std_logic_1164.all;


entity e_4bit_adder is
    port (  byte1, byte2            : in  std_logic_vector(3 downto 0);
            carry_in                : in  std_logic;
            carry_out               : out std_logic;
            s                       : out std_logic_vector(3 downto 0));
end entity e_4bit_adder;

architecture e_4bit_adder of e_4bit_adder is
    signal carry : std_logic_vector(4 downto 0);

    signal in_t  : std_logic;
    component e_1bit_adder is
        port (  bit1, bit2, carry_in  : in  std_logic;
                s, carry_out          : out std_logic);
    end component;
begin
    carry(0) <= carry_in;

    gen: for j in 0 to 3 generate
        in_t <= byte2(j) xor carry_in;
        I_S: e_1bit_adder port map(byte1(j), in_t, carry(j), s(j), carry(j+1));
    end generate;

    carry_out <= carry(4);

end architecture e_4bit_adder;
