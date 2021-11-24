// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sat May 22 19:18:38 2021
// Host        : Barry-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/OneDrive/VivadoProj/EE332/flappy_bird/flappy_bird.srcs/sources_1/ip/clk_wiz_100m_40m/clk_wiz_100m_40m_stub.v
// Design      : clk_wiz_100m_40m
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_100m_40m(clk_40m, reset, locked, clk_in)
/* synthesis syn_black_box black_box_pad_pin="clk_40m,reset,locked,clk_in" */;
  output clk_40m;
  input reset;
  output locked;
  input clk_in;
endmodule
