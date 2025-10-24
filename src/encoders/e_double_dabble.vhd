library ieee;
use ieee.std_logic_1164.all;

entity e_double_dabble is
    port (
        bin_in      : in  std_logic_vector(7 downto 0);
        bcd_ones    : out std_logic_vector(3 downto 0);
        bcd_tens    : out std_logic_vector(3 downto 0);
        bcd_hundreds: out std_logic_vector(3 downto 0)
    );
end entity e_double_dabble;

architecture a_double_dabble of e_double_dabble is
    signal s_t, s_u, s_v, s_w, s_x, s_y, s_z : std_logic_vector(3 downto 0);

    -- Intermediate signals for port-map inputs
    signal in_t, in_u, in_v, in_x, in_z, in_w, in_y : std_logic_vector(3 downto 0);

    component e_dabble is
        port (
            slv_original : in  std_logic_vector(3 downto 0);
            slv_modified : out std_logic_vector(3 downto 0)
        );
    end component;
begin
    -- Prepare static inputs for each dabble stage
    in_t <= '0' & bin_in(7 downto 5);
    in_u <= s_t(2 downto 0) & bin_in(4);
    in_v <= s_u(2 downto 0) & bin_in(3);
    in_x <= s_v(2 downto 0) & bin_in(2);
    in_z <= s_x(2 downto 0) & bin_in(1);

    in_w <= '0' & s_t(3) & s_u(3) & s_v(3);
    in_y <= s_w(2 downto 0) & s_x(3);

    -- Chain of dabble stages
    t_stage: e_dabble port map(in_t, s_t);
    u_stage: e_dabble port map(in_u, s_u);
    v_stage: e_dabble port map(in_v, s_v);
    x_stage: e_dabble port map(in_x, s_x);
    z_stage: e_dabble port map(in_z, s_z);

    w_stage: e_dabble port map(in_w, s_w);
    y_stage: e_dabble port map(in_y, s_y);

    -- Output assignment
    bcd_hundreds <= "00" & s_w(3) & s_y(3);
    bcd_tens     <= s_y(2 downto 0) & s_z(3);
    bcd_ones     <= s_z(2 downto 0) & bin_in(0);
end architecture a_double_dabble;
