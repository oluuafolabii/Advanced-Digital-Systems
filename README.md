# Advanced Digital Systems

VHDL coursework and an FPGA-oriented arcade game project. The repository contains small combinational-logic exercises, VGA/Pong labs, homework, and a `space_invaders` top-level design with VGA graphics, push-button controls, and a multiplexed seven-segment score display. It also includes archived Vivado projects and generated run reports; those are historical artifacts, not a clean automated build.

## Where to start

- [`Project/VHDL/space_invaders.vhd`](Project/VHDL/space_invaders.vhd) wires the game, clock generator, VGA sync, button inputs, and score display.
- [`Project/VHDL/ship_n_laser.vhd`](Project/VHDL/ship_n_laser.vhd) implements the game state and pixel-level drawing for the ship, lasers, aliens, lives, and text. The top-level maps left/right to movement, up to start, center to shoot, and down to quit.
- [`Project/VHDL/vga_sync.vhd`](Project/VHDL/vga_sync.vhd), [`Project/VHDL/leddec16.vhd`](Project/VHDL/leddec16.vhd), and [`Project/VHDL/space_invaders.xdc`](Project/VHDL/space_invaders.xdc) provide display timing, score decoding, and pin/clock constraints. The included `clk_wiz_0*.vhd` files are generated Xilinx IP, not standalone portable VHDL.
- [`labs/`](labs/) progresses from an even detector through mux/decoder and VGA/Pong examples; [`HW/`](HW/) contains related exercises. For a compact example, see [`labs/lab2/VHDL/even_detector.vhd`](labs/lab2/VHDL/even_detector.vhd) and its [testbench](labs/lab2/VHDL/tb_even_detector.vhd).

## Opening and verification

The archived Vivado projects target a Nexys A7-100T / `xc7a100tcsg324-1` and record use of Vivado 2024.2. Some `.xpr` source paths point to an old `New folder` location, so opening them on a different machine may require relinking sources or creating a fresh Vivado project using `Project/VHDL/` and the XDC constraints. A compatible Xilinx IP/simulation environment is required for the clock generator. The archived run logs report successful bitstream generation, **but the routed timing report says timing constraints were not met** (worst negative slack −6.047 ns in one archived run). That is not evidence of a timing-clean or hardware-validated game.

The even-detector testbench exercises eight input patterns; there is no automated end-to-end game test in the repository. No fresh synthesis, simulation, or on-board test was performed for this README. Check the constraints, timing, and device behavior before treating the project as deployable hardware.
