----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/05/23 18:23:11
-- Design Name: 
-- Module Name: pillar - move
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

entity pillar is
    Port(btn : in std_logic;
            ng : in std_logic; -- new game
            clk    : in std_logic;
            reset  : in std_logic;
            gap1 : out integer range 0 to 399;
            gap2 : out integer range 0 to 399;
            pos1 : out integer range 0 to 799;
            pos2 : out integer range 0 to 799;
            dis1, dis2 : out std_logic);
end pillar;

architecture move of pillar is
    type state is (hide, load, up, mid, down);
    component button is
        Port (btn : in std_logic;
                clk    : in std_logic;
                reset  : in std_logic;
                pulse  : out std_logic);
    end component button;
    
    signal pulse, restart : std_logic;
    signal rand1_reg, rand1_next, rand2_reg, rand2_next : integer range 0 to 2;
    signal dis1_reg, dis1_next, dis2_reg, dis2_next : std_logic := '0';
    signal pos1_reg, pos1_next : integer range 0 to 799;
    signal gap1_reg, gap1_next : integer range 0 to 399;
    signal state1_reg, state1_next : state;
    signal state2_reg, state2_next : state;
    signal pos2_reg, pos2_next : integer range 0 to 799;
    signal gap2_reg, gap2_next : integer range 0 to 399;
--    signal state_count, state_count_next : integer range 0 to 4999999;
    signal pos_count, pos_count_next : integer range 0 to 399999;
    
begin
    tap : button
    port map( 
        btn => btn,
        reset => reset,
        clk => clk,
        pulse => pulse);
        
    new_game : button
    port map( 
        btn => ng,
        reset => reset,
        clk => clk,
        pulse => restart);
        
    process(clk, reset, restart) is
    begin
        if reset = '1' then
            pos1_reg <= 0;
            gap1_reg <= 175;
            state1_reg <= hide;
            dis1_reg <= '0';
            rand1_reg <= 0;
            pos2_reg <= 499;
            gap2_reg <= 175;
            state2_reg <= hide;
            dis2_reg <= '0';
            rand2_reg <= 0;
            pos_count <= 0;
            pos_count_next <= 0;
        elsif restart = '1' then
            pos1_reg <= 0;
            gap1_reg <= 175;
            state1_reg <= hide;
            dis1_reg <= '0';
            rand1_reg <= 0;
            pos2_reg <= 499;
            gap2_reg <= 175;
            state2_reg <= hide;
            dis2_reg <= '0';
            rand2_reg <= 0;
            pos_count <= 0;
            pos_count_next <= 0;
        elsif rising_edge(clk) then
            if pos_count = 399999 then
                pos1_reg <= pos1_next;
                pos2_reg <= pos2_next;
            end if;
            pos_count_next <= pos_count + 1;
            pos_count <= pos_count_next;
            state1_reg <= state1_next;
            state2_reg <= state2_next;
            dis1_reg <= dis1_next;
            dis2_reg <= dis2_next;
            gap1_reg <= gap1_next;
            gap2_reg <= gap2_next;
            rand1_reg <= rand1_next;
            rand2_reg <= rand2_next;
        end if;
    end process;

    process(clk)
    begin
        rand1_next <= rand1_reg;
        rand2_next <= rand2_reg;
        if rising_edge(clk) then
            pos1_next <= pos1_reg - 1;
            pos2_next <= pos2_reg - 1;
            if pulse = '1' then
                rand1_next <= rand1_reg + 1;
                rand2_next <= rand2_reg + 2;
            end if;
        end if;
            
    end process;
    
    process(clk)
    begin
        dis1_next <= dis1_reg;
        state1_next <= state1_reg;
        gap1_next <= gap1_reg;
        case state1_reg is
        when hide =>
            dis1_next <= '0';
            if pulse = '1' then
                state1_next <= load;
            else
                state1_next <= hide;
            end if;
        when load =>
            dis1_next <= '0';
            if pos1_reg = 799 then
                state1_next <= mid;
            else
                state1_next <= load;
            end if;
        when mid =>
            dis1_next <= '1';
            gap1_next <= 175;
            if pos1_reg = 799 then
                case rand1_reg is
                when 0 =>
                    state1_next <= down;
                when 1 =>
                    state1_next <= mid;
                when 2 =>
                    state1_next <= up;
                end case;
            else
                state1_next <= state1_reg;
            end if;
        when down =>
            dis1_next <= '1';
            gap1_next <= 275;
            if pos1_reg = 799 then
                case rand1_reg is
                when 0 =>
                    state1_next <= down;
                when 1 =>
                    state1_next <= mid;
                when 2 =>
                    state1_next <= up;
                end case;
            else
                state1_next <= state1_reg;
            end if;
        when up =>
            dis1_next <= '1';
            gap1_next <= 75;
            if pos1_reg = 799 then
                case rand1_reg is
                when 0 =>
                    state1_next <= down;
                when 1 =>
                    state1_next <= mid;
                when 2 =>
                    state1_next <= up;
                end case;
            else
                state1_next <= state1_reg;
            end if;
        when others =>
            state1_next <= state1_reg;
        end case;
    end process;
        
    process(clk)
    begin
        dis2_next <= dis2_reg;
        state2_next <= state2_reg;
        gap2_next <= gap2_reg;
        case state2_reg is
        when hide =>
            dis2_next <= '0';
            if pulse = '1' then
                state2_next <= load;
            else
                state2_next <= hide;
            end if;
        when load =>
            dis2_next <= '0';
            if pos2_reg = 799 then
                state2_next <= mid;
            else
                state2_next <= load;
            end if;
        when mid =>
            dis2_next <= '1';
            gap2_next <= 200;
            if pos2_reg = 799 then
                case rand2_reg is
                when 0 =>
                    state2_next <= down;
                when 1 =>
                    state2_next <= mid;
                when 2 =>
                    state2_next <= up;
                end case;
            else
                state2_next <= state2_reg;
            end if;
        when down =>
            dis2_next <= '1';
            gap2_next <= 300;
            if pos2_reg = 799 then
                case rand2_reg is
                when 0 =>
                    state2_next <= down;
                when 1 =>
                    state2_next <= mid;
                when 2 =>
                    state2_next <= up;
                end case;
            else
                state2_next <= state2_reg;
            end if;
        when up =>
            dis2_next <= '1';
            gap2_next <= 100;
            if pos2_reg = 799 then
                case rand2_reg is
                when 0 =>
                    state2_next <= down;
                when 1 =>
                    state2_next <= mid;
                when 2 =>
                    state2_next <= up;
                end case;
            else
                state2_next <= state2_reg;
            end if;
        when others =>
            state2_next <= state2_reg;
        end case;
    end process;
    
    pos1 <= pos1_reg;
    gap1 <= gap1_reg;
    dis1 <= dis1_reg;
    pos2 <= pos2_reg;
    gap2 <= gap2_reg;
    dis2 <= dis2_reg;
end move;
