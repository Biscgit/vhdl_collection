library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_e_4bit_fast_adder_wave is
end entity;

architecture sim of tb_e_4bit_fast_adder_wave is
    signal byte1, byte2 : std_logic_vector(3 downto 0);
    signal carry_in     : std_logic := '0';
    signal carry_out    : std_logic;
    signal s            : std_logic_vector(3 downto 0);
begin
    uut: entity work.e_4bit_fast_adder
        port map (
            byte1     => byte1,
            byte2     => byte2,
            carry_in  => carry_in,
            carry_out => carry_out,
            s         => s
        );

    -- Stimulus process
    process
    begin
        -- Addition tests
        carry_in <= '0';
        for cin in 0 to 1 loop
        if cin = 1 then
            carry_in <= '1';
        else
            carry_in <= '0';
        end if;
            for a in 0 to 15 loop
                for b in 0 to 15 loop
                    byte1 <= std_logic_vector(to_unsigned(a, 4));
                    byte2 <= std_logic_vector(to_unsigned(b, 4));
                    wait for 20 ns;
                end loop;
            end loop;
        end loop;

        report "Waveform simulation finished!" severity note;
        wait;
    end process;
end architecture;
