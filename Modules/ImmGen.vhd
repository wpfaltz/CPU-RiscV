library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity Immediate_Generator is
    Port( 
        instruction : in std_logic_vector(31 downto 0);  	-- Entrada da Instrução 
        immediate   : out std_logic_vector(31 downto 0)  		-- Saída do Valor Imediato
    );
end Immediate_Generator;

architecture Behavioral of Immediate_Generator is
    signal op_code      : std_logic_vector(6 downto 0);  		-- Sinal para armazenr o op_code da instrução
    signal S_imm        : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";  -- Sinal auxiliar para definição do imediato

begin

    op_code <= instruction(6 downto 0);  -- Definição do op_code

    process(op_code)
    begin
        if (op_code = "0010011" or op_code = "0000011" or op_code = "1100111") then  	-- Tipo I 
            S_imm(11 downto 0)  <= instruction(31 downto 20);  					-- Seleciona o imediato 
            S_imm(31 downto 12) <= (others => instruction(31));  				-- Extensão do Bit de Sinal
        elsif (op_code = "1101111") then  									-- Tipo UJ 
            S_imm(20) <= instruction(31);  									-- Seleciona o imediato
            S_imm(10 downto 1) <= instruction(30 downto 21);					-- Seleciona o imediato
            S_imm(11) <= instruction(20);									-- Seleciona o imediato	
            S_imm(19 downto 12) <= instruction(19 downto 12);					-- Seleciona o imediato
            S_imm(31 downto 21) <= (others => instruction(31));					-- Extensão do Bit de Sinal
        elsif (op_code = "0110111" or op_code = "0010111") then										-- Tipo U 
        	  S_imm(31 downto 12) <= instruction(31 downto 12);  					-- Seleciona o imediato	
        elsif (op_code = "0100011") then  									-- Tipo S 
            S_imm(11 downto 5)  <= instruction(31 downto 25);  					-- Seleciona o imediato
            S_imm(4 downto 0)   <= instruction(11 downto 7);   					-- Seleciona o imediato
            S_imm(31 downto 12) <= (others => instruction(31));  				-- Extensão do Bit de Sinal
        elsif (op_code = "1100011") then  									-- Tipo SB
            S_imm(12)           <= instruction(31);          					-- Seleciona o imediato
            S_imm(11)           <= instruction(7);           					-- Seleciona o imediato
            S_imm(10 downto 5)  <= instruction(30 downto 25);  					-- Seleciona o imediato
            S_imm(4 downto 1)   <= instruction(11 downto 8);   					-- Seleciona o imediato
            S_imm(31 downto 13) <= (others => instruction(31));  				-- Extensão do Bit de Sinal
        end if;
    end process;

    immediate <= S_imm;  												-- Atribui o valor imeadiato à saída

end Behavioral;
