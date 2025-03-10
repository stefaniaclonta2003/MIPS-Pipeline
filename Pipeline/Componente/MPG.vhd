library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is
signal cnt : std_logic_vector(15 downto 0) := (others=>'0');
signal Q1, Q2, Q3, Q4: std_logic;
begin
    enable<= Q2 and (not Q3);
    process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process;
    process(clk)
    begin
        if rising_edge(clk) then
            --cnt <= cnt + 1;
            if cnt(15 downto 0)="1111111111111111" then
                Q1 <= btn;
            end if;
            Q2<=Q1;
            Q3<=Q2;
        end if;
    end process;
end Behavioral;