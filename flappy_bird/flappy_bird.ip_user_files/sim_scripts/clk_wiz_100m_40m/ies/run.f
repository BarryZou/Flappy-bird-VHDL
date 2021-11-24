-makelib ies_lib/xil_defaultlib -sv \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../flappy_bird.srcs/sources_1/ip/clk_wiz_100m_40m/clk_wiz_100m_40m_clk_wiz.v" \
  "../../../../flappy_bird.srcs/sources_1/ip/clk_wiz_100m_40m/clk_wiz_100m_40m.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

