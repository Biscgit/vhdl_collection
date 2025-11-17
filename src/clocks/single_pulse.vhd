library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity e_single_pulse is
    port (
        slv_clock, slv_input: in std_logic;
        slv_output: out std_logic
    );
end entity e_single_pulse;

architecture a_single_pulse of e_single_pulse is
    signal slv_storage: std_logic;
begin
    p_toggle: process(slv_clock, slv_input)
    begin
        if rising_edge(slv_clock) then
            slv_output <= '0';
            if slv_input = '1' and slv_storage = '0' then
                slv_storage <= '1';
                slv_output <= '1';
            elsif slv_input = '0' then
                slv_storage <= '0';
            end if;
        end if;
    end process;
end architecture a_single_pulse;
