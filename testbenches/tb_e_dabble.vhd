library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_e_dabble is
end entity;

architecture sim of tb_e_dabble is
    signal original : std_logic_vector(3 downto 0);
    signal modified : std_logic_vector(3 downto 0);

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
    uut: entity work.e_dabble
        port map (
            slv_original => original,
            slv_modified => modified
        );

    process
        variable input_dec  : integer;
        variable output_dec : integer;
    begin
        report " dec_in | bin_in | bin_out | dec_out";
        report "------------------------------------";

        for i in 0 to 15 loop
            original <= std_logic_vector(to_unsigned(i, 4));
            wait for 1 ns;

            input_dec  := i;
            output_dec := to_integer(unsigned(modified));

            report "   " & integer'image(input_dec)
                 & "    | " & to_bin_str(original)
                 & "   | " & to_bin_str(modified)
                 & "   | " & integer'image(output_dec);
        end loop;

        wait;
    end process;
end architecture sim;
