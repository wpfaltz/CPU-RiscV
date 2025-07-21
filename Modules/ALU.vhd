
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ALU is
    port(
    A, B      	: in std_logic_vector(31 downto 0);  -- Operandos A e B de 32 bits da ALU
    controle   : in std_logic_vector(3 downto 0);   -- Entrada responsável por determinar a operação da ALU
    resultado  : out std_logic_vector(31 downto 0); -- Resultado da operação feita pela ALU
    f_zero     : out std_logic);                    -- Flag indicadora de resultado igual a zero na operacão da ALU
end ALU;

architecture Behavioral of ALU is

signal resultado_temp : std_logic_vector(31 downto 0);  -- Vetor auxiliar que armazena o resultado da operação

begin
	
    resultado_temp <= (A + B) when controle = "0010" else                  -- Soma OP
    			   	 (A - B) when controle = "0110" else                  -- Subtração OP
    			   	 (A XOR B) when controle = "0101" else                -- XOR OP
    			   	 (A OR B) when controle = "0001" else                 -- OR OP
    			   	 (A AND B) when controle = "0000" else                -- AND OP 
    			   	 (std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))))) when controle = "0011" else   	-- Shift Left OP
    			   	 (std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))))) when controle = "0111";    		-- Shift Right OP
        			
    resultado <= resultado_temp;                            			    			-- Atribuição do valor final à saída resultado
    f_zero <= '1' when resultado_temp = "00000000000000000000000000000000" else '0';	-- Sinalização se o resultado é zero 
    														    			-- (Se zero_sig(32) for '0', f_zero é '1', caso contrário, f_zero é '0')
end Behavioral;
