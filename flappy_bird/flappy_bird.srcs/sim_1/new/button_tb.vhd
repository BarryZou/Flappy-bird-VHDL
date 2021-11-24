----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/05/20 11:07:57
-- Design Name: 
-- Module Name: button_tb - press_tb
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity button_tb is
--  Port ( );
end button_tb;

architecture press_tb of button_tb is
    component button is 
        Port ( btn : in std_logic;
           clk    : in std_logic;
           reset  : in std_logic;
           pulse  : out std_logic);
    end component button;
    signal btn_tb, clk_tb, reset_tb, pulse_tb : std_logic;
begin
    UUT : button port map(CLK => CLK_tb, RESET => RESET_TB, btn => btn_tb, pulse => pulse_tb);
    
    clk_proc : process is
        constant PERIOD: time := 10 ns;
    begin
        clk_tb <= '1';
        wait for PERIOD / 2;
        clk_tb <= '0';
        wait for PERIOD / 2;
    end process clk_proc;

    RESET_TB <= '1', '0' after 30 ns;
    btn_tb <= '0', '1' after 50 ns, '0' after 700 ns, '1' after 1000 ns, '0' after 130000 ns;
end press_tb;
