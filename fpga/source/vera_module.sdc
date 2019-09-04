# 14MHz PHI2
#create_clock -name {extbus_phi2} -period 71 [get_ports extbus_phi2]

# 25MHz system clock
create_clock -name {clk25} -period 40 [get_ports clk25]

# Define clock domains to be independent
#set_clock_groups -group [get_clocks extbus_phi2] -group [get_clocks clk25] -asynchronous

# Setup time (tCLK - tSU)
#set_input_delay 25 -max -clock [get_clocks extbus_phi2] [get_ports {extbus_cs_n extbus_rw_n extbus_a[0] extbus_a[1] extbus_a[2]}]

#set_input_delay 25 -max -clock [get_clocks extbus_phi2] [get_ports {extbus_d[0] extbus_d[1] extbus_d[2] extbus_d[3] extbus_d[4] extbus_d[5] extbus_d[6] extbus_d[7]}]

# Hold time (tH)
#set_input_delay 10 -min -clock [get_clocks extbus_phi2] -add_delay [get_ports {extbus_d[0] extbus_d[1] extbus_d[2] extbus_d[3] extbus_d[4] extbus_d[5] extbus_d[6] extbus_d[7]}]

#set_output_delay 10 -clock [get_clocks extbus_phi2] -add_delay [get_ports {extbus_d[0] extbus_d[1] extbus_d[2] extbus_d[3] extbus_d[4] extbus_d[5] extbus_d[6] extbus_d[7]}]


set_output_delay 10 -clock [get_clocks clk25] [get_ports {vga_r[0] vga_r[1] vga_r[2] vga_r[3] vga_g[0] vga_g[1] vga_g[2] vga_g[3] vga_b[0] vga_b[1] vga_b[2] vga_b[3] vga_hsync vga_vsync}]
