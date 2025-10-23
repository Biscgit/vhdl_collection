library ieee;
use ieee.std_logic_1164.all;


entity e_4bit_comp is
   port ( slv_X, slv_Y        : in  std_logic_vector(3 downto 0);
          slv_z               : out std_logic);
end entity e_4bit_comp;

architecture a_4bit_comp of e_4bit_comp is
    signal g, e, l : std_logic_vector(3 downto 0);


    component e_1bit_comp is
    port ( slv_X, slv_Y         : in  std_logic;
          slv_xgy               : out std_logic;
          slv_xey               : out std_logic;
          slv_xly               : out std_logic);
    end component;
begin

    assign_reverse_order: for j in 3 downto 0 generate
        I_x : e_1bit_comp port map(slv_X(j), slv_Y(j), g(j), e(j), l(j));
    end generate;

    slv_z <= g(3) or (e(3) and g(2)) or (e(3) and e(2) and g(1)) or (e(3) and e(2) and e(1) and g(0));


end architecture a_4bit_comp;
