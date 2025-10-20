library ieee;
use ieee.std_logic_1164.all;


entity e_1bit_comp is
   port ( slv_X, slv_Y          : in  std_logic;
          slv_xgy               : out std_logic;
          slv_xey               : out std_logic;
          slv_xly               : out std_logic);
end entity e_1bit_comp;

architecture a_1bit_comp of e_1bit_comp is
begin
    slv_xgy <=     slv_X     and not  slv_Y;
    slv_xey <=     slv_X     xnor     slv_Y;
    slv_xly <= not slv_X     and      slv_Y;
end architecture a_1bit_comp;
