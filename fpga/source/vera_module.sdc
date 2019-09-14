# 25MHz system clock
create_clock -name {clk25} -period 40 [get_ports clk25]

set_output_delay 10 -clock [get_clocks clk25] [get_ports {vga_r[0] vga_r[1] vga_r[2] vga_r[3] vga_g[0] vga_g[1] vga_g[2] vga_g[3] vga_b[0] vga_b[1] vga_b[2] vga_b[3] vga_hsync vga_vsync}]
