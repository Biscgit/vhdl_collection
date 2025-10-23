library ieee;
use ieee.std_logic_1164.all;

entity e_dabble is
    port (
        slv_original : in  std_logic_vector(3 downto 0);
        slv_modified : out std_logic_vector(3 downto 0)
    );
end entity e_dabble;

architecture rtl of e_dabble is
    -- Intermediate signals
    signal s_xor_0_3   : std_logic;
    signal s_xor_1_3   : std_logic;
    signal s_nor_2_3   : std_logic;
    signal s_nor_xors  : std_logic;
    signal s_nor_chain : std_logic;
    signal s_or_chain  : std_logic;
begin
    -- Basic operations
    s_xor_0_3 <= slv_original(0) xor slv_original(3);
    s_xor_1_3 <= slv_original(1) xor slv_original(3);
    s_nor_2_3 <= slv_original(2) nor slv_original(3);

    -- Intermediate combinations
    s_nor_xors  <= s_xor_0_3 nor s_xor_1_3;
    s_nor_chain <= s_nor_xors nor s_nor_2_3;
    s_or_chain  <= s_xor_0_3 or s_nor_2_3;

    -- Output logic
    slv_modified(0) <= slv_original(0) xor s_nor_chain;
    slv_modified(1) <= s_or_chain and s_xor_1_3;
    slv_modified(2) <= slv_original(1) nor s_or_chain;
    slv_modified(3) <= s_nor_chain;
end architecture rtl;
