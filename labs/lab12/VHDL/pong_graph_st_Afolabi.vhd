library ieee;
use ieee.std_logic_1164.all;         -- For std_logic and std_logic_vector types
use ieee.numeric_std.all;             -- For unsigned arithmetic operations

-- Entity declaration
entity pong_graph_st is
    port (
        clk        : in std_logic;                      -- Clock input
        reset      : in std_logic;                      -- Asynchronous reset input
        btn        : in std_logic_vector(4 downto 0);    -- Button inputs (movement and firing)
        video_on   : in std_logic;                      -- VGA video on/off signal
        pixel_x    : in std_logic_vector(9 downto 0);    -- Current pixel x-coordinate
        pixel_y    : in std_logic_vector(9 downto 0);    -- Current pixel y-coordinate
        graph_rgb  : out std_logic_vector(2 downto 0)    -- VGA output color
    );
end pong_graph_st;

-- Architecture definition
architecture sq_ball_arch of pong_graph_st is

    -- Signal declarations
    signal refr_tick : std_logic;                        -- 60Hz refresh tick signal
    signal pix_x, pix_y : unsigned(9 downto 0);           -- Pixel x and y as unsigned for arithmetic

    -- VGA display resolution constants
    constant MAX_X : integer := 640;                     -- VGA horizontal pixel max
    constant MAX_Y : integer := 480;                     -- VGA vertical pixel max

    -- Spaceship (paddle) bar boundaries
    signal bar_x_l, bar_x_r : unsigned(9 downto 0);       -- Left and right x-coordinates
    constant BAR_X_SIZE : integer := 16;                  -- Spaceship width
    signal bar_y_t, bar_y_b : unsigned(9 downto 0);       -- Top and bottom y-coordinates
    constant BAR_Y_SIZE : integer := 16;                  -- Spaceship height

    -- Spaceship (bar) position registers
    signal bar_y_reg, bar_y_next : unsigned(9 downto 0);  -- Vertical position register and next value
    signal bar_x_reg, bar_x_next : unsigned(9 downto 0);  -- Horizontal position register and next value
    constant BAR_V : integer := 4;                        -- Spaceship movement speed (pixels per refresh)

    -- Spaceship image ROM (16x16 bitmap)
    type ship_rom_type is array(0 to 15) of std_logic_vector(0 to 15);
    constant SHIP_ROM : ship_rom_type := (
        "0000001111111111",  -- Row 0
        "0000011111111111",  -- Row 1
        "0000111111111111",  -- Row 2
        "0001111111111111",  -- Row 3
        "0011111111111111",  -- Row 4
        "0111111111111111",  -- Row 5
        "1111111111111111",  -- Row 6
        "1111111111111111",  -- Row 7
        "1111111111111111",  -- Row 8
        "1111111111111111",  -- Row 9
        "1111111111111111",  -- Row 10
        "0111111111111110",  -- Row 11
        "0111111111111110",  -- Row 12
        "0011111111111100",  -- Row 13
        "0011111111111100",  -- Row 14
        "0001111111111000"   -- Row 15
    );

-- Additional signal declarations (for firing ball) will be added below...

begin
    -- (Processes and further code will go here)

end sq_ball_arch;
