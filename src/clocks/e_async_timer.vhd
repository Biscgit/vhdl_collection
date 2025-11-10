library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity e_async_timer is
    -- a configurable timer which sets the output to 1 for one single clock cycle
    generic (
        -- system's clock frquency in HZ
        CLOCK_FREQUENCY: unsigned := to_unsigned(50_000_000, 28);
        -- integer of duration
        DURATION: unsigned := to_unsigned(1, 1);
        -- multiple of seconds, i.e. milliseconds as duration would require this to be set to 1_000
        TIME_UNIT: unsigned := to_unsigned(1, 1)
    );
    port (
        -- input clock signal
        slv_clk: in std_logic;
        -- reset
        slv_reset: in std_logic;
        -- output signal
        slv_output: out std_logic;
        slv_counter: out unsigned
    );
end entity e_async_timer;

architecture a_async_timer of e_async_timer is
    constant CNT_WIDTH: natural := (CLOCK_FREQUENCY'length + DURATION'length - TIME_UNIT'length);
    subtype T_COUNTER is unsigned(CNT_WIDTH - 1 downto 0);

    constant CNT_LIMIT: T_COUNTER := resize(CLOCK_FREQUENCY * DURATION / TIME_UNIT - 1, CNT_WIDTH);
    signal slv_internal_counter: T_COUNTER;
begin
    slv_counter <= slv_internal_counter;

    p_counter: process(slv_clk, slv_reset)
    begin
        -- asynchronously resetable
        if slv_reset = '0' then
            slv_internal_counter <= to_unsigned(0, CNT_WIDTH);
        elsif rising_edge(slv_clk) then
            slv_output <= '0';
            if slv_internal_counter >= CNT_LIMIT then
                -- set to 1 to avoid skipping one clock cycle
                slv_internal_counter <= to_unsigned(0, CNT_WIDTH);
                slv_output <= '1';
            else
                slv_internal_counter <= slv_internal_counter + 1;
            end if;
        end if;
    end process p_counter;

end architecture a_async_timer;