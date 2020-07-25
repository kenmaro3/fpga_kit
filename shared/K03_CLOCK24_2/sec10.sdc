create_clock -name CLK1 -period 20.000 [get_ports {CLK2}]
derive_clock_uncertainty
set_input_delay -clock {CLK1} 1 [all_inputs]
set_output_delay -clock {CLK1} 1 [all_outputs]