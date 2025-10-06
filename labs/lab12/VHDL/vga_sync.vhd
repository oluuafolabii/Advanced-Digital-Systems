library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_sync is
    port(
        clk       : in  std_logic;                     -- 100 MHz clock
        reset     : in  std_logic;                     -- active-high reset
        hsync     : out std_logic;
        vsync     : out std_logic;
        comp_sync : out std_logic;
        video_on  : out std_logic;
        p_tick    : out std_logic;                     -- 25 MHz pixel tick
        pixel_x   : out std_logic_vector(9 downto 0);  -- 0-639
        pixel_y   : out std_logic_vector(9 downto 0)   -- 0-479
    );
end entity;

architecture rtl of vga_sync is

  -- VGA timing constants for 640×480 @ 60 Hz
  constant HD : integer := 640;  -- display width
  constant HF : integer := 16;   -- front porch
  constant HB : integer := 48;   -- back porch
  constant HR : integer := 96;   -- sync pulse

  constant VD : integer := 480;  -- display height
  constant VF : integer := 11;   -- front porch
  constant VB : integer := 31;   -- back porch
  constant VR : integer := 2;    -- sync pulse

  -- Clock-divider to get 25 MHz tick from 100 MHz
  signal clk_div_reg, clk_div_next : unsigned(1 downto 0);
  signal pixel_tick               : std_logic;

  -- Horizontal & vertical counters
  signal h_cnt_reg, h_cnt_next : unsigned(9 downto 0);
  signal v_cnt_reg, v_cnt_next : unsigned(9 downto 0);

  -- End-of-line/frame flags
  signal h_end, v_end : std_logic;

  -- Raw sync signals, plus 2-stage pipe to avoid glitches
  signal h_sync_reg, h_sync_next, h_sync_d1, h_sync_d2 : std_logic;
  signal v_sync_reg, v_sync_next, v_sync_d1, v_sync_d2 : std_logic;

begin

  ------------------------------------------------------------------
  -- Clock divider & pixel_tick generation
  ------------------------------------------------------------------
  clk_div_next <= clk_div_reg + 1;
  pixel_tick   <= '1' when clk_div_reg = "11" else '0';

  process(clk, reset)
  begin
    if reset = '1' then
      clk_div_reg <= (others=>'0');
      h_cnt_reg   <= (others=>'0');
      v_cnt_reg   <= (others=>'0');
      h_sync_reg  <= '0';
      v_sync_reg  <= '0';
      h_sync_d1   <= '0';
      h_sync_d2   <= '0';
      v_sync_d1   <= '0';
      v_sync_d2   <= '0';
    elsif rising_edge(clk) then
      clk_div_reg <= clk_div_next;
      h_cnt_reg   <= h_cnt_next;
      v_cnt_reg   <= v_cnt_next;
      h_sync_reg  <= h_sync_next;
      v_sync_reg  <= v_sync_next;
      h_sync_d1   <= h_sync_reg;
      h_sync_d2   <= h_sync_d1;
      v_sync_d1   <= v_sync_reg;
      v_sync_d2   <= v_sync_d1;
    end if;
  end process;

  ------------------------------------------------------------------
  -- Horizontal counter (0-799)
  ------------------------------------------------------------------
  process(h_cnt_reg, h_end, pixel_tick)
  begin
    if pixel_tick = '1' then
      if h_end = '1' then
        h_cnt_next <= (others=>'0');
      else
        h_cnt_next <= h_cnt_reg + 1;
      end if;
    else
      h_cnt_next <= h_cnt_reg;
    end if;
  end process;

  ------------------------------------------------------------------
  -- Vertical counter (0-524)
  ------------------------------------------------------------------
  process(v_cnt_reg, h_end, v_end, pixel_tick)
  begin
    if pixel_tick = '1' and h_end = '1' then
      if v_end = '1' then
        v_cnt_next <= (others=>'0');
      else
        v_cnt_next <= v_cnt_reg + 1;
      end if;
    else
      v_cnt_next <= v_cnt_reg;
    end if;
  end process;

  ------------------------------------------------------------------
  -- End-of-line/frame flags
  ------------------------------------------------------------------
  h_end <= '1' when h_cnt_reg = to_unsigned(HD+HF+HB+HR-1, 10) else '0';
  v_end <= '1' when v_cnt_reg = to_unsigned(VD+VF+VB+VR-1, 10) else '0';

  ------------------------------------------------------------------
  -- Sync pulse generation
  ------------------------------------------------------------------
  h_sync_next <= '1' when
    (h_cnt_reg >= to_unsigned(HD+HF,10)
     and h_cnt_reg <  to_unsigned(HD+HF+HR,10))
  else '0';

  v_sync_next <= '1' when
    (v_cnt_reg >= to_unsigned(VD+VF,10)
     and v_cnt_reg <  to_unsigned(VD+VF+VR,10))
  else '0';

  ------------------------------------------------------------------
  -- Output assignments
  ------------------------------------------------------------------
  hsync      <= h_sync_d2;
  vsync      <= v_sync_d2;
  comp_sync  <= h_sync_reg xor v_sync_reg;
  video_on   <= '1' when 
                  (h_cnt_reg < to_unsigned(HD,10)) and
                  (v_cnt_reg < to_unsigned(VD,10))
                else '0';
  pixel_x    <= std_logic_vector(h_cnt_reg);
  pixel_y    <= std_logic_vector(v_cnt_reg);

  -- finally drive the output port from our internal tick
  p_tick     <= pixel_tick;

end architecture;
