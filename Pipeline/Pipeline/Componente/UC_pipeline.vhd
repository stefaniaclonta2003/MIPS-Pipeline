library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UC_pipeline is
 Port ( 
 Instr: in std_logic_vector(5 downto 0);
 RegDst: out std_logic;
 ExtOp:out std_logic;
 ALUSrc: out std_logic;
 Branch: out std_logic;
 Br_gez: out std_logic;
 Jump: out std_logic;
 MemWrite: out std_logic;
 MemToReg: out std_logic;
 RegWrite: out std_logic;
 ALUOp: out std_logic_vector(1 downto 0)
 );
end UC_pipeline;

architecture Behavioral of UC_pipeline is
begin
process(Instr)
begin
--Initializam toate semnalele de control cu 0 la inceputul procesului.
--In functie de opcode-ul furnizat, le vom actualiza.
RegDst <= '0';
ExtOp <= '0';
ALUSrc <= '0';
Branch <= '0';              
Jump <= '0';
MemWrite <= '0';
MemtoReg <= '0';
RegWrite <= '0';
ALUOp <= "00";
Br_gez <= '0';
case Instr is
    when "000000" =>--tip R
        RegDst <= '1';
        RegWrite <= '1';
        ALUOp <= "10";
    when "001000" =>--addi
        ExtOp <= '1';
        ALUSrc <= '1';
        RegWrite <= '1';
        ALUOp <= "00";
    when "001101" =>--ori
        ALUSrc <= '1';
        RegWrite <= '1';
        ALUOp <= "11";
    when "100011" =>--lw
        ExtOp <= '1';
        ALUSrc <= '1';
        MemtoReg <= '1';
        RegWrite <= '1';
        ALUOp <= "00";
    when "101011" =>--sw
        ExtOp <= '1';
        ALUSrc <= '1';
        MemWrite <= '1';
        ALUOp <= "00";
    when "000100" =>--beq
        ExtOp <= '1';
        Branch <= '1';
        ALUOp <= "01";
    when "000001" =>--bgez
        ExtOp <= '1';
        Br_gez <= '1';
        ALUOp <= "01";
    when "000010" =>--j
        Jump <= '1';
    when others =>
end case;
end process;
end Behavioral;