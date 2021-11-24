library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity hex7seg is
port(x: in std_logic_vector(3 downto 0);
    LED: out std_logic_vector(6 downto 0));
end hex7seg;

architecture Behavioral of hex7seg is
begin
process (x) is
begin
    case x is
        when "0000" =>
            LED <= "0000001";
        when "0001" =>
            LED <= "1001111";
        when "0010" =>
            LED <= "0010010";
        when "0011" =>
            LED <= "0000110";
        when "0100" =>
            LED <= "1001100";
        when "0101" =>
            LED <= "0100100";
        when "0110" =>
            LED <= "0100000";
        when "0111" =>
            LED <= "0001111";
        when "1000" =>
            LED <= "0000000";
        when "1001" =>
            LED <= "0000100";
        when "1010" =>
            LED <= "0001000";
        when "1011" =>
            LED <= "1100000";
        when "1100" =>
            LED <= "0110001";
        when "1101" =>
            LED <= "1000010";
        when "1110" =>
            LED <= "0110000";
        when "1111" =>
            LED <= "0111000";
        when others =>
            LED <= "1111111";
    end case;
end process;
end Behavioral;
