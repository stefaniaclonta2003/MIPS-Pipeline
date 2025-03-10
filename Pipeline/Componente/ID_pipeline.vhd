library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;


entity ID_pipeline is
    Port (
        writeData : in  std_logic_vector(31 downto 0);
        regWrite : in std_logic;
        --regDst : in std_logic;
        ExtOp : in std_logic;
        Instr : in std_logic_vector(25 downto 0);
        clk : in std_logic;
        en : in std_logic;
        WA : in std_logic_vector (4 downto 0);
        readData1 : out std_logic_vector(31 downto 0);
        readData2 : out std_logic_vector(31 downto 0);
        Ext_Imm : out std_logic_vector(31 downto 0);
        func: out std_logic_vector(5 downto 0);
        rt : out std_logic_vector(4 downto 0);
        rd :  out std_logic_vector(4 downto 0);
        sa: out std_logic_vector(4 downto 0)
    );
end ID_pipeline;

architecture Behavioral of ID_pipeline is
    type Register_File is array (0 to 31) of std_logic_vector(31 downto 0);
    signal RF : Register_File := (others => (others => '0'));
    signal  writeAddr : std_logic_vector(4 downto 0);
    signal  instr_20_16 :  std_logic_vector(4 downto 0);
    signal  instr_15_11 :  std_logic_vector(4 downto 0);
    
begin

writeAddr <= WA;
Ext_Imm(15 downto 0) <= Instr(15 downto 0);
Ext_Imm(31 downto 16) <= (others => Instr(15)) when ExtOp = '1' else(others => '0');

    
    func <= instr(5 downto 0);
    sa <= instr(10 downto 6);
process(regWrite,en,clk)
begin
    if falling_edge(clk) then
        if en='1' and RegWrite='1' then
            RF(conv_integer(WriteAddr))<=WriteData;
        end if;
    end if;
end process;
readData1<=RF(conv_integer(Instr(25 downto 21)));
readData2<=RF(conv_integer(Instr(20 downto 16)));
rt <= Instr(20 downto 16);
rd <= Instr(15 downto 11);

end Behavioral;