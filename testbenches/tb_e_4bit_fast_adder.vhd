library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_e_4bit_fast_adder is
end entity;

architecture sim of tb_e_4bit_fast_adder is
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

    process
        variable a, b, cin : integer;
        variable expected_sum  : integer;
        variable expected_cout : integer;
        variable actual_sum    : integer;
        variable actual_cout   : integer;
    begin
        carry_in <= '0';
                    wait for 2 ns;
        for a in 0 to 15 loop
            for b in 0 to 15 loop
                for cin in 0 to 1 loop
                    byte1    <= std_logic_vector(to_unsigned(a, 4));
                    byte2    <= std_logic_vector(to_unsigned(b, 4));
                    if cin = 1 then
                        carry_in <= '1';
                    else
                        carry_in <= '0';
                    end if;
                    wait for 2 ns;

                    expected_sum  := (a + b + cin) mod 16;
                    expected_cout := (a + b + cin) / 16;
                    actual_sum    := to_integer(unsigned(s));
                    if carry_out = '1' then
                        actual_cout := 1;
                    else
                        actual_cout := 0;
                    end if;

                    assert actual_sum = expected_sum
                        report "Sum mismatch: " &
                               integer'image(a) & " + " & integer'image(b) &
                               " + " & integer'image(cin) &
                               " => expected " & integer'image(expected_sum) &
                               " got " & integer'image(actual_sum)
                        severity failure;

                    assert actual_cout = expected_cout
                        report "Carry mismatch: " &
                               integer'image(a) & " + " & integer'image(b) &
                               " + " & integer'image(cin) &
                               " => expected carry " & integer'image(expected_cout) &
                               " got " & std_logic'image(carry_out)
                        severity failure;
                end loop;
            end loop;
        end loop;

        report "All adder test cases passed!" severity note;
        wait;
    end process;
end architecture;
