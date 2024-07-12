--------------------------------------------------------------------------------
-- Project :
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE ieee.numeric_std.all;  

ENTITY ROM_MIPS IS
  PORT (
  ------------------------------------------------------------------------------

    clock      : IN  std_logic;                    
    MIPS_Indice_Instruccion        : IN  std_logic_vector(31 DOWNTO 0); 
    Usar_Little_Endian: IN std_logic; 
    
  ------------------------------------------------------------------------------

    byte        : OUT std_logic_vector(31 DOWNTO 0);               
    nibble        : OUT std_logic_vector(30 DOWNTO 0);
    word: OUT  std_logic_vector(29 DOWNTO 0);
    ROM_WORD: OUT std_logic_vector(31 DOWNTO 0) 
    );
END ROM_MIPS;
--------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF ROM_MIPS IS

type t_Memory is array (0 to 64) of std_logic_vector(31 downto 0);

signal byte_out        :  std_logic_vector(31 DOWNTO 0);               
signal nibble_out        :  std_logic_vector(30 DOWNTO 0);
signal word_out:   std_logic_vector(29 DOWNTO 0);

signal ROM: t_Memory:=(x"a2d3a1e0",x"1ad3f349",others =>x"00000000") ; 
signal rom_word_out : std_logic_vector(31 DOWNTO 0);


BEGIN
-- Process that handles the cache behavior on clock edge
process (clock)
	begin
	if clock = '1' then
		byte_out <= MIPS_Indice_Instruccion; 
		nibble_out <= MIPS_Indice_Instruccion(31 DOWNTO 1); 
		word_out <= MIPS_Indice_Instruccion(31 DOWNTO 2);  

		rom_word_out <= ROM(to_integer(unsigned(word_out))); 
	end if; 
end process;

byte <= byte_out; 
nibble <= nibble_out; 
word <= word_out; 
ROM_WORD <= rom_word_out;

END TypeArchitecture;
