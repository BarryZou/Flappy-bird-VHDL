----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/05/22 21:15:30
-- Design Name: 
-- Module Name: bird - height_control
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

entity bird is
    Port(btn : in std_logic;
            start : in std_logic;
            clk    : in std_logic;
            reset  : in std_logic;
            height : out integer range 0 to 469);
end bird;

architecture height_control of bird is
    type state is (ready, fall3, fall2, fall1, hold, up1, up2, up3);
    component button is
        Port (btn : in std_logic;
                clk    : in std_logic;
                reset  : in std_logic;
                pulse  : out std_logic);
    end component button;
       
    signal pulse : std_logic;
    signal restart  : std_logic;
    signal state_reg, state_next : state;
    signal height_reg, height_next : integer range 0 to 469;
    signal state_count, state_count_next : integer range 0 to 4999999;
    signal hei_count, hei_count_next : integer range 0 to 999999;
--    signal jitter_count, jitter_next : integer range 0 to 7;
       
begin
    tap : button
    port map( 
        btn => btn,
        reset => reset,
        clk => clk,
        pulse => pulse);
        
    new_game : button
        port map( 
            btn => start,
            reset => reset,
            clk => clk,
            pulse => restart);
        
    process(clk, reset, restart) is
    begin
        if reset = '1' then
            height_reg <= 260;
            state_reg <= ready;
            state_count <= 0;
            state_count_next <= 0;
            hei_count <= 0;
            hei_count_next <= 0;
        elsif restart = '1' then
            height_reg <= 260;
            state_reg <= ready;
            state_count <= 0;
            state_count_next <= 0;
            hei_count <= 0;
            hei_count_next <= 0;
        elsif rising_edge(clk) then
            if pulse = '1' then
                state_reg <= up3;
                state_count <= 4999998;
                hei_count <= 999998;
            else
                if state_count = 4999999 then
                    state_reg <= state_next;
                end if;
                if hei_count = 999999 then
                    height_reg <= height_next;
                end if;
            end if;
            hei_count_next <= hei_count + 1;
            state_count_next <= state_count + 1;
            hei_count <= hei_count_next;
            state_count <= state_count_next;
        end if;
    end process;
    
    process(state_reg) is
    begin
        case state_reg is
        when ready =>
            height_next <= height_reg;
            state_next <= ready;
        when hold =>
            height_next <= height_reg;
            state_next <= fall1;
        when up3 =>
            if height_reg > 4 then
                height_next <= height_reg - 4;
            else
                height_next <= 0;
            end if;
            state_next <= up2;
        when up2 =>
            if height_reg > 2 then
                height_next <= height_reg - 2;
            else
                height_next <= 0;
            end if;
            state_next <= up1;
        when up1 =>
            if height_reg > 1 then
                height_next <= height_reg - 1;
            else
                height_next <= 0;
            end if;
            state_next <= hold;
        when fall1 =>
            if height_reg < 468 then
                height_next <= height_reg + 1;
            else
                height_next <= 469;
            end if;
            state_next <= fall2;
        when fall2 =>
            if height_reg < 467 then
                height_next <= height_reg + 2;
            else
                height_next <= 469;
            end if;
            state_next <= fall3;
        when fall3 =>
            if height_reg < 465 then
                height_next <= height_reg + 4;
            else
                height_next <= 469;
            end if;
            state_next <= fall3;
        end case;
    end process;
    
    height <= height_reg;
end height_control;
