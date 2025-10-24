library ieee;
use ieee.std_logic_1164.all;

entity e_7seg_encoder is
    port (
        slv_binary_input:   in  std_logic_vector(3 downto 0);
        slv_7seg_encoded:   out std_logic_vector(6 downto 0);
        slv_enabled:        in std_logic := '1'
    );
end entity e_7seg_encoder;

architecture a_7seg_encoder of e_7seg_encoder is
    signal slv_combined : std_logic_vector(4 downto 0);
begin
    slv_combined <= (slv_enabled & slv_binary_input);

    with slv_combined select
        slv_7seg_encoded <= "1000000" when "10000",
                            "1111001" when "10001",
                            "0100100" when "10010",
                            "0110000" when "10011",
                            "0011001" when "10100",
                            "0010010" when "10101",
                            "0000010" when "10110",
                            "1111000" when "10111",
                            "0000000" when "11000",
                            "0010000" when "11001",
                            "0001000" when "11010",
                            "0000011" when "11011",
                            "1000110" when "11100",
                            "0100001" when "11101",
                            "0000110" when "11110",
                            "0001110" when "11111",
                            "1111111" when others;
end a_7seg_encoder;
