library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pong_graph_st is
    port(
        clk, reset     : in  std_logic;
        btn            : in  std_logic_vector(3 downto 0);  -- { RIGHT, LEFT, DOWN, UP }
        video_on       : in  std_logic;
        pixel_x, pixel_y : in  std_logic_vector(9 downto 0);
        graph_rgb      : out std_logic_vector(2 downto 0)
    );
end pong_graph_st;

architecture sq_ball_arch of pong_graph_st is

    -- Generate a 60 Hz frame tick to pace all movement logic
    signal refr_tick : std_logic;

    -- Convert pixel indices to unsigned for comparisons
    signal pix_x, pix_y : unsigned(9 downto 0);

    -- Display dimensions
    constant MAX_X : integer := 640;
    constant MAX_Y : integer := 480;

    -- Left and right wall boundaries
    constant WALL_X_L : integer := 32;
    constant WALL_X_R : integer := 35;

    -- Paddle dimensions and position registers
    constant BAR_X_SIZE : integer := 3;     -- paddle width
    constant BAR_Y_SIZE : integer := 72;    -- paddle height
    signal bar_x_reg, bar_y_reg : unsigned(9 downto 0);
    signal bar_x_next, bar_y_next : unsigned(9 downto 0);

    -- Horizontal movement step size (pixels per frame)
    constant BAR_V : integer := 4;

    -- Square ball dimensions and position registers
    constant BALL_SIZE : integer := 8;
    signal ball_x_reg, ball_y_reg : unsigned(9 downto 0);
    signal ball_x_next, ball_y_next : unsigned(9 downto 0);

    -- Ball velocity registers (signed via two's-complement)
    signal x_delta_reg, y_delta_reg       : unsigned(9 downto 0);
    signal x_delta_next, y_delta_next     : unsigned(9 downto 0);
    constant BALL_V_P : unsigned(9 downto 0) := to_unsigned(2, 10);
    constant BALL_V_N : unsigned(9 downto 0) := unsigned(to_signed(-2, 10));

    -- ROM for round-ball mask (8×8)
    type rom_type is array(0 to 7) of std_logic_vector(7 downto 0);
    constant BALL_ROM : rom_type := (
        "00111100", "01111110", "11111111", "11111111",
        "11111111", "11111111", "01111110", "00111100"
    );

    -- ROM address and data signals
    signal rom_addr, rom_col : unsigned(2 downto 0);
    signal rom_data          : std_logic_vector(7 downto 0);
    signal rom_bit           : std_logic;

    -- Object-on flags and color vectors
    signal wall_on, bar_on, sq_ball_on, rd_ball_on : std_logic;
    signal wall_rgb, bar_rgb, ball_rgb             : std_logic_vector(2 downto 0);

begin

    ----------------------------------------------------------------------------
    -- POSITION REGISTERS: update on rising clock or reset
    ----------------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            bar_x_reg     <= (others => '0');
            bar_y_reg     <= (others => '0');
            ball_x_reg    <= (others => '0');
            ball_y_reg    <= (others => '0');
            x_delta_reg   <= BALL_V_P;  -- initial velocity
            y_delta_reg   <= BALL_V_P;
        elsif rising_edge(clk) then
            bar_x_reg     <= bar_x_next;
            bar_y_reg     <= bar_y_next;
            ball_x_reg    <= ball_x_next;
            ball_y_reg    <= ball_y_next;
            x_delta_reg   <= x_delta_next;
            y_delta_reg   <= y_delta_next;
        end if;
    end process;

    -- Convert pixel inputs for arithmetic
    pix_x <= unsigned(pixel_x);
    pix_y <= unsigned(pixel_y);

    ----------------------------------------------------------------------------
    -- FRAME TICK GENERATOR: assert at start of vertical blank (once per frame)
    ----------------------------------------------------------------------------
    refr_tick <= '1'
      when (pix_y = to_unsigned(MAX_Y+1,10) and pix_x = to_unsigned(0,10))
      else '0';

    ----------------------------------------------------------------------------
    -- WALL: vertical stripe in blue
    ----------------------------------------------------------------------------
    wall_on  <= '1' when (WALL_X_L <= pix_x and pix_x <= WALL_X_R) else '0';
    wall_rgb <= "001";

    ----------------------------------------------------------------------------
    -- PADDLE RENDERING
    ----------------------------------------------------------------------------
    -- derive paddle edges from center register
    bar_on  <= '1' when
      (unsigned(bar_x_reg) <= pix_x and pix_x <= unsigned(bar_x_reg) + BAR_X_SIZE - 1)
   and (unsigned(bar_y_reg) <= pix_y and pix_y <= unsigned(bar_y_reg) + BAR_Y_SIZE - 1)
    else '0';
    bar_rgb <= "010";

    ----------------------------------------------------------------------------
    -- PADDLE MOVEMENT: adjust bar_x_next/bar_y_next on every frame tick
    ----------------------------------------------------------------------------
    process(bar_x_reg, bar_y_reg, refr_tick, btn)
    begin
        -- default: hold position
        bar_x_next <= bar_x_reg;
        bar_y_next <= bar_y_reg;

        if refr_tick = '1' then
            -- DOWN
            if btn(1) = '1' and (bar_y_reg + BAR_Y_SIZE < to_unsigned(MAX_Y,10)) then
                bar_y_next <= bar_y_reg + to_unsigned(BAR_V,10);

            -- UP
            elsif btn(0) = '1' and (bar_y_reg > to_unsigned(BAR_V-1,10)) then
                bar_y_next <= bar_y_reg - to_unsigned(BAR_V,10);

            -- RIGHT
            elsif btn(3) = '1' and (bar_x_reg + BAR_X_SIZE < to_unsigned(MAX_X,10)) then
                bar_x_next <= bar_x_reg + to_unsigned(BAR_V,10);

            -- LEFT
            elsif btn(2) = '1' and (bar_x_reg > to_unsigned(BAR_V-1,10)) then
                bar_x_next <= bar_x_reg - to_unsigned(BAR_V,10);
            end if;
        end if;
    end process;

    ----------------------------------------------------------------------------
    -- SQUARE BALL RENDERING
    ----------------------------------------------------------------------------
    sq_ball_on <= '1' when
      (unsigned(ball_x_reg) <= pix_x and pix_x <= unsigned(ball_x_reg) + BALL_SIZE - 1)
   and (unsigned(ball_y_reg) <= pix_y and pix_y <= unsigned(ball_y_reg) + BALL_SIZE - 1)
    else '0';
    ball_rgb <= "100";

    ----------------------------------------------------------------------------
    -- ROUND BALL MASK: lookup ROM and overlay on square sprite
    ----------------------------------------------------------------------------
    rom_addr <= pix_y(2 downto 0) - ball_y_reg(2 downto 0);
    rom_col  <= pix_x(2 downto 0) - ball_x_reg(2 downto 0);
    rom_data <= BALL_ROM(to_integer(rom_addr));
    rom_bit  <= rom_data(to_integer(rom_col));

    rd_ball_on <= '1' when (sq_ball_on = '1' and rom_bit = '1') else '0';

    ----------------------------------------------------------------------------
    -- BALL MOVEMENT: advance position by delta each frame
    ----------------------------------------------------------------------------
    ball_x_next <= ball_x_reg + x_delta_reg when refr_tick = '1' else ball_x_reg;
    ball_y_next <= ball_y_reg + y_delta_reg when refr_tick = '1' else ball_y_reg;

    ----------------------------------------------------------------------------
    -- BALL BOUNCE LOGIC: reverse delta on collision
    ----------------------------------------------------------------------------
    process(ball_x_reg, ball_y_reg, x_delta_reg, y_delta_reg)
    begin
        x_delta_next <= x_delta_reg;
        y_delta_next <= y_delta_reg;

        -- bounce on top or bottom
        if ball_y_reg < to_unsigned(1,10) then
            y_delta_next <= BALL_V_P;
        elsif ball_y_reg + BALL_SIZE > to_unsigned(MAX_Y,10) then
            y_delta_next <= BALL_V_N;

        -- bounce on left wall
        elsif ball_x_reg < to_unsigned(WALL_X_L+1,10) then
            x_delta_next <= BALL_V_P;

        -- reflect off paddle
        elsif rd_ball_on = '1' then
            x_delta_next <= BALL_V_N;
        end if;
    end process;

    ----------------------------------------------------------------------------
    -- FINAL PIXEL OUTPUT: zero while video_off, else priority among objects
    ----------------------------------------------------------------------------
    process(video_on, wall_on, bar_on, rd_ball_on)
    begin
        if video_on = '0' then
            graph_rgb <= "000";       -- blank
        elsif wall_on = '1' then
            graph_rgb <= wall_rgb;
        elsif bar_on = '1' then
            graph_rgb <= bar_rgb;
        elsif rd_ball_on = '1' then
            graph_rgb <= ball_rgb;
        else
            graph_rgb <= "110";       -- background (yellow)
        end if;
    end process;

end sq_ball_arch;
