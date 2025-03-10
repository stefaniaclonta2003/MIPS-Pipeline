library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity MEM_pipeline is
  Port (
  MemWrite : in std_logic;
  ALUResin : std_logic_vector(31 downto 0);
  RD2 : in std_logic_vector(31 downto 0);
  clk : in std_logic;
  en : in std_logic;
  MemData : out std_logic_vector(31 downto 0);
  ALUResout : out std_logic_vector(31 downto 0)
   );
end MEM_pipeline;

architecture Behavioral of MEM_pipeline is
type data_memory is array(0 to 63) of std_logic_vector(31 downto 0);
signal MEM : data_memory :=(
    X"00000005",--00--de aici citim numarul de elemente N
    X"00000001",--01--de aici citim vectorul
    X"00000002",--02
    X"00000003",--03
    X"00000004",--04
    X"00000005",--05
    X"00000000",--06--aici scriem rezultatul
    others => X"00000000"
);
begin
process(clk)
begin
    if rising_edge(clk) then
        if MemWrite = '1' then
            MEM(conv_integer(ALUResin(7 downto 2)))<=RD2;
        end if;
    end if;
end process;
MemData <= MEM(conv_integer(ALUResin(7 downto 2)));
ALUResout <= ALUResin;
end Behavioral;