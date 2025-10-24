library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_e_double_dabble is
end entity;

architecture sim of tb_e_double_dabble is
    signal bin_in      : std_logic_vector(7 downto 0);
    signal bcd_ones    : std_logic_vector(3 downto 0);
    signal bcd_tens    : std_logic_vector(3 downto 0);
    signal bcd_hundreds: std_logic_vector(3 downto 0);

    -- Helper: convert std_logic_vector to string (binary)
    function to_bin_str(v : std_logic_vector) return string is
        variable s : string(1 to v'length);
        variable idx : integer := 1;
    begin
        for i in v'reverse_range loop
            if v(i) = '1' then
                s(idx) := '1';
            else
                s(idx) := '0';
            end if;
            idx := idx + 1;
        end loop;
        return s;
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
        variable input_dec : integer;
        variable dec_hundreds    : integer;
        variable dec_tens        : integer;
        variable dec_ones        : integer;
        variable bcd_combined : unsigned(11 downto 0);
    begin
        report " dec_in | bin_in    | BCD_out (hundreds tens ones) | dec_out";
        report "-------------------------------------------------------------";

        for i in 0 to 255 loop
            bin_in <= std_logic_vector(to_unsigned(i, 8));
            wait for 1 ns;

            input_dec := i;
            bcd_combined := unsigned(bcd_hundreds & bcd_tens & bcd_ones);
            dec_hundreds := to_integer(unsigned(bcd_hundreds));
            dec_tens     := to_integer(unsigned(bcd_tens));
            dec_ones     := to_integer(unsigned(bcd_ones));

            report "  " & integer'image(input_dec)
                & "    | " & to_bin_str(bin_in)
                & " | " & to_bin_str(bcd_hundreds) & " "
                            & to_bin_str(bcd_tens) & " "
                            & to_bin_str(bcd_ones)
                & "        | " & integer'image(dec_hundreds)
                & "            | " & integer'image(dec_tens)
                & "       | " & integer'image(dec_ones);
        end loop;

        wait;
    end process;
end architecture sim;
