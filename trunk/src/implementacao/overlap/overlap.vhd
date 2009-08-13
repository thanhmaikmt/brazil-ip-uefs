------------------------------------------------------------------------
--Projeto Brazil-IP UEFS
--Decodificador MPEG-2 AAC                     Implementa��o do Overlapping/Adding
--Descri��o do arquivo: Overlapping/Adding e sua fun��o de sobreposi��o de seq��ncia de janelas adjacentes
------------------------------------------------------------------------





-------------------------------------------------------------------------------
--parameter int HALF_WINDOW_SIZE = 512;

--fun��o utilizada na verifica��o
--function void overlap(int sequencePos,
--						int pcm_in_1[(HALF_WINDOW_SIZE-1):0],
--						int pcm_in_2[(HALF_WINDOW_SIZE-1):0],
--						ref int pcm_out[(HALF_WINDOW_SIZE-1):0]);
--
--
-- int sequencePos - definido de acordo ao enum SequencePosition { middle = 0, first = 1, last = 2}
-- pcm_in_1 - ultima metade da primeira seq��ncia
-- pcm_in_2 - primeira metada da segunda seq��ncia
-- pcm_out - sa�da
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 		-- Para std_logic
use IEEE.Std_Logic_unsigned.all;   	-- Para conv_integer


entity OVERLAP2 is
port(
     sequencePos	: in std_logic_vector(1 downto 0);
	 pcm_in_1, pcm_in_2	: in std_logic_vector(31 downto 0); --duas palavras de 16 bits
	 --Res 	: buffer std_logic_vector(15 downto 0);
     pcm_out	: buffer std_logic_vector(31 downto 0)
     );
end OVERLAP2;

architecture comportamento of OVERLAP2 is
begin

  process(sequencePos)
    variable pcm1_0, pcm1_1, pcm2_0, pcm2_1, result_0, result_1 : INTEGER;
  begin

	pcm1_0:= conv_integer(pcm_in_1(15 downto  0));
	pcm1_1:= conv_integer(pcm_in_1(31 downto 16));
	
	pcm2_0:= conv_integer(pcm_in_2(15 downto  0));
	pcm2_1:= conv_integer(pcm_in_2(31 downto 16));
	
    case sequencePos is
      when "00" => 	result_0 := pcm1_0 + pcm2_0;
					result_1 := pcm1_1 + pcm2_1;

      -- first
      when "01" => 	result_0 := pcm2_0;
					result_1 := pcm2_1;
					-- pcm_out[i] = pcm_in_2[i];
      
      -- last
      when "10" => 	result_0 := pcm1_0;
					result_1 := pcm1_1;
					-- pcm_out[i] = pcm_in_1[i];		    

      
	  when others => pcm_out <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    end case;
	
	pcm_out(15 downto  0) <= conv_std_logic_vector(result_0, 16);
	pcm_out(31 downto 16) <= conv_std_logic_vector(result_1, 16);
	
  end process;

end comportamento;