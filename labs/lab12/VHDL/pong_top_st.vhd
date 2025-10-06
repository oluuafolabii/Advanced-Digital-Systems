library ieee;
use ieee.std_logic_1164.all;

entity pong_top_st is
  port(
    clk        : in  std_logic;
    reset      : in  std_logic;
    btn        : in  std_logic_vector(2 downto 0);  -- btn(0)=up, btn(1)=down, btn(2)=fire
    hsync      : out std_logic;
    vsync      : out std_logic;
    comp_sync  : out std_logic;
    rgb        : out std_logic_vector(2 downto 0)   -- 3-bit color output
  );
end entity;

architecture arch of pong_top_st is
  signal pixel_x, pixel_y : std_logic_vector(9 downto 0);
  signal video_on, p_tick : std_logic;
  signal rgb_next, rgb_reg: std_logic_vector(2 downto 0);
begin

  --------------------------------------------------------------------
  -- VGA sync generator
  --------------------------------------------------------------------
  vga_sync_unit: entity work.vga_sync
    port map(
      clk       => clk,
      reset     => reset,
      hsync     => hsync,
      vsync     => vsync,
      comp_sync => comp_sync,
      video_on  => video_on,
      p_tick    => p_tick,
      pixel_x   => pixel_x,
      pixel_y   => pixel_y
    );

  --------------------------------------------------------------------
  -- Pong graphics (bouncing ball + paddle + missile)
  -- Bind to the 'rtl' architecture of pong_graph_st.vhd
  --------------------------------------------------------------------
  pong_graph_unit: entity work.pong_graph_st(rtl)
    port map(
      clk       => clk,
      reset     => reset,
      btn       => btn,
      video_on  => video_on,
      pixel_x   => pixel_x,
      pixel_y   => pixel_y,
      graph_rgb => rgb_next
    );

  --------------------------------------------------------------------
  -- RGB output register (synchronized to pixel tick)
  --------------------------------------------------------------------
  process(clk)
  begin
    if rising_edge(clk) then
      if p_tick = '1' then
        rgb_reg <= rgb_next;
      end if;
    end if;
  end process;

  rgb <= rgb_reg;

end architecture;
