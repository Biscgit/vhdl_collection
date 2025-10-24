library ieee;
use ieee.std_logic_1164.all;

entity e_4bit_fast_adder is
    port (
        byte1, byte2    : in  std_logic_vector(3 downto 0);
        carry_in        : in  std_logic;
        carry_out       : out std_logic;
        s               : out std_logic_vector(3 downto 0)
    );
end entity;

architecture a_4bit_fast_adder of e_4bit_fast_adder is
    signal g, p         : std_logic_vector(3 downto 0);
    signal g1, p1       : std_logic_vector(3 downto 0);
    signal g2, p2       : std_logic_vector(3 downto 0);
begin
    -- Stage 0: generate & propagate
    gen_gp: for j in 0 to 3 generate
        g(j) <= byte1(j) and byte2(j);
        p(j) <= byte1(j) xor byte2(j);
    end generate;

    -- Stage 1: distance 1
    g1(0) <= g(0) or (p(0) and carry_in);
    p1(0) <= p(0) and carry_in;
    stage1: for j in 1 to 3 generate
        g1(j) <= g(j) or (p(j) and g(j-1));
        p1(j) <= p(j) and p(j-1);
    end generate;

    -- Stage 2: distance 2
    g2(0) <= g1(0);
    p2(0) <= p1(0);

    g2(1) <= g1(1) or (p1(1) and g1(0));
    p2(1) <= p1(1) and p1(0);

    stage2: for j in 2 to 3 generate
        g2(j) <= g1(j) or (p1(j) and g1(j-2));
        p2(j) <= p1(j) and p1(j-2);
    end generate;


    s(0) <= p(0) xor carry_in;
    final: for j in 1 to 3 generate
        s(j) <= p(j) xor g2(j-1);
    end generate;

    carry_out <= g2(3) or (p2(3) and carry_in);
end architecture a_4bit_fast_adder;
