----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/05/22 18:35:29
-- Design Name: 
-- Module Name: click - add
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity click is
    Port ( btn : in std_logic;
       clk    : in std_logic;
       reset  : in std_logic;
       num  : out std_logic_vector(3 downto 0));
end click;

architecture add of click is
    component button is
        Port ( btn : in std_logic;
           clk    : in std_logic;
           reset  : in std_logic;
           pulse  : out std_logic);
    end component button;
    signal pulse : std_logic;
    signal num_reg, num_next : std_logic_vector(3 downto 0);

begin
    adder : button
        port map( 
                        btn => btn,
                        reset => reset,
                        clk => clk,
                        pulse => pulse);
    
    process(clk, reset)
    begin
        if reset = '1' then
            num_reg <= (others => '0');
        elsif rising_edge(clk) then
            num_reg <= num_next;
        end if;
    end process;
    
    process(num_reg)
    begin
        if pulse = '1' then
            num_next <= num_reg + 1;
        else
            num_next <= num_reg;
        end if;
    end process;
num <= num_reg;
end add;
