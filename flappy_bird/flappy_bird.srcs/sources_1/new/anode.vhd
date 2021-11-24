library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity anode is
port(CLK : in std_logic;
    A, B : in std_logic_vector(7 downto 0);
    AN: out std_logic_vector(7 downto 0);
    CONTROL : out std_logic_vector(6 downto 0));
end anode;

architecture driver of anode is
    component hex7seg
        port(x : in std_logic_vector (3 downto 0);
            LED : out std_logic_vector (6 downto 0));
    end component hex7seg;

    signal in0, in1, in2, in3, in4, in5, in6, in7 : std_logic_vector(3 downto 0);
    signal trans_reg : std_logic_vector (16 downto 0);
    signal trans_next : std_logic_vector (16 downto 0);
    signal b_next : std_logic_vector (2 downto 0);
    signal b_reg : std_logic_vector (2 downto 0);
    signal input : std_logic_vector (3 downto 0);
    
begin

decoder: hex7seg
port map(x => input, LED => CONTROL);

process(clk) is
begin
    if clk'event and clk = '1' then
        trans_reg <= trans_next;
        b_reg <= b_next;
    end if;
end process;

process(trans_reg, b_reg) is
begin
    b_next <= b_reg;
    if trans_reg = 99999 then
        b_next <= b_reg + 1;
        trans_next <= (others => '0');
    else
        trans_next <= trans_reg + 1;
    end if;
end process;

process(b_reg) is
begin
    case b_reg is
        when "000" =>
            input <= in0;
            AN <= "11111110";
        when "001" =>
            input <= in1;
            AN <= "11111101";
        when "010" =>
            input <= in2;
            AN <= "11111011";
        when "011" =>
            input <= in3;
            AN <= "11110111";
        when "100" =>
            input <= in4;
            AN <= "11101111";
        when "101" =>
            input <= in5;
            AN <= "11011111";
        when "110" =>
            input <= in6;
            AN <= "10111111";
        when "111" =>
            input <= in7;
            AN <= "01111111";
        when others =>
            input <= in0;
            AN <= "11111101";
    end case;
end process;

in0 <= A(3 downto 0);
in1 <= A(7 downto 4);
in2 <= "1100";
in3 <= "0101";
in4 <= B(3 downto 0);
in5 <= B(7 downto 4);
in6 <= "0101";
in7 <= "1000";

end driver;
