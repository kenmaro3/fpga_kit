create_clock -name CLK1 -period 20.000 [get_ports {CLK1}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[0]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[1]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[2]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[3]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[4]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[5]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[6]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[7]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[8]}]
set_output_delay -clock { CLK1 } 10 [get_ports {LED[9]}]