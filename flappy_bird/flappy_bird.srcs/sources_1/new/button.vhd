----------------------------------------------------------------------------------
-- Company: SUSTech
-- Engineer: Haoyu Zou
-- 
-- Create Date: 2021/05/20 10:16:32
-- Design Name: Button -> Impulse
-- Module Name: button - press
-- Project Name: flappy_bird
-- Target Devices: Nexys 4 DDR
-- Tool Versions: 
-- Description: Generate a pulse at the rising edge of button input with 10 ms debouncing
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

entity button is
    Port ( btn : in std_logic;
           clk    : in std_logic;
           reset  : in std_logic;
           pulse  : out std_logic);
end button;

architecture press of button is
    type state is (neg, counting, pos);
    signal state_reg, state_next : state;
    signal count, count_next : integer range 0 to 999999;
begin
    -- CLK Process
    process(clk, reset)
    begin
        if (reset = '1') then
            state_reg <= neg;
        elsif rising_edge(clk) then
            state_reg <= state_next;
            count <= count_next;
        end if;
    end process;
    
    -- Next state logic with debouncing
    process(state_reg, btn, count)
    begin
        -- Default output and state
        state_next <= state_reg;
        count_next <= count;
        pulse <= '0';
        case state_reg is
            when neg =>
                if (btn = '1') then
                    count_next <= 0;
                    state_next <= counting;
                else
                    state_next <= neg;
                end if;
            when counting =>
                if (btn = '1') then
                    if (count < 999999) then
                        count_next <= count + 1;
                        state_next <= counting;
                    else
                        pulse <= '1';
                        state_next <= pos;
                    end if;
                elsif (btn = '0') then
                    count_next <= 0;
                    state_next <= neg;
                end if;
            when pos =>
                if (btn = '1') then
                    state_next <= pos;
                else
                    state_next <= neg;
                end if;
        end case;
    end process; 

end press;
