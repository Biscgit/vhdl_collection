library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_e_double_dabble is
end entity;

architecture sim of tb_e_double_dabble is
    signal bin_in       : std_logic_vector(7 downto 0);
    signal bcd_ones     : std_logic_vector(3 downto 0);
    signal bcd_tens     : std_logic_vector(3 downto 0);
    signal bcd_hundreds : std_logic_vector(3 downto 0);

    function to_bcd(value : integer) return std_logic_vector is
        variable bcd : std_logic_vector(3 downto 0);
    begin
        bcd := std_logic_vector(to_unsigned(value, 4));
        return bcd;
    end function;

begin
    uut: entity work.e_double_dabble
        port map (
            bin_in       => bin_in,
            bcd_ones     => bcd_ones,
            bcd_tens     => bcd_tens,
            bcd_hundreds => bcd_hundreds
        );

    process
        variable dec_val : integer;
        variable exp_ones, exp_tens, exp_hundreds : integer;
    begin
        for i in 0 to 255 loop
            bin_in <= std_logic_vector(to_unsigned(i, 8));
            wait for 2 ns;

            dec_val := i;
            exp_hundreds := dec_val / 100;
            exp_tens     := (dec_val / 10) mod 10;
            exp_ones     := dec_val mod 10;

            assert to_integer(unsigned(bcd_hundreds)) = exp_hundreds
                report "Mismatch at " & integer'image(i) & ": hundreds expected " &
                       integer'image(exp_hundreds) & " got " &
                       integer'image(to_integer(unsigned(bcd_hundreds)))
                severity failure;

            assert to_integer(unsigned(bcd_tens)) = exp_tens
                report "Mismatch at " & integer'image(i) & ": tens expected " &
                       integer'image(exp_tens) & " got " &
                       integer'image(to_integer(unsigned(bcd_tens)))
                severity failure;

            assert to_integer(unsigned(bcd_ones)) = exp_ones
                report "Mismatch at " & integer'image(i) & ": ones expected " &
                       integer'image(exp_ones) & " got " &
                       integer'image(to_integer(unsigned(bcd_ones)))
                severity failure;
        end loop;

        report "All test cases passed!" severity note;
        wait;
    end process;
end architecture;

