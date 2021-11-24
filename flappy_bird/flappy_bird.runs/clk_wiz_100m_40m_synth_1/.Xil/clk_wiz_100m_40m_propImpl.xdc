set_property SRC_FILE_INFO {cfile:d:/OneDrive/VivadoProj/EE332/flappy_bird/flappy_bird.srcs/sources_1/ip/clk_wiz_100m_40m/clk_wiz_100m_40m.xdc rfile:../../../flappy_bird.srcs/sources_1/ip/clk_wiz_100m_40m/clk_wiz_100m_40m.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.1
