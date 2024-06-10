--------------------------------------------------------------------------------
-- Description :
-- Cache for pipelined MIPS processor. 
-- 2 way associative.
-- 32 bit addresses and 32 bit data output. 
-- Address is divided this way: 
--  tag is of 10 bits, index is of 8 bits and offset is 5 bits. 
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE ieee.numeric_std.all;  

ENTITY cacheLRU IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    clock      : IN  std_logic;           
    Address: IN std_logic_vector(31 DOWNTO 0);

  ------------------------------------------------------------------------------
	hit : OUT std_logic; 
	data_out: OUT std_logic_vector(31 DOWNTO 0);
		tag_out : OUT std_logic_vector (16 DOWNTO 0); 
		index_out : OUT std_logic_vector (8 DOWNTO 0); 
		offset_out :OUT std_logic_vector (5 DOWNTO 0);
	miss_out: OUT std_logic
    );
END cacheLRU;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF cacheLRU IS

type bloque is array(0 to 63) of std_logic_vector(16 downto 0);
type t_set is array(0 to 255) of bloque;
signal cache0 : t_set;
signal cache1 : t_set; 

type t_tag is array(0 to 255) of std_logic_vector(16 downto 0);

type t_valid is array(0 to 255) of std_logic;

type t_Dirty is array(0 to 255) of std_logic;

type t_LRU is array(0 to 255) of std_logic; 



signal s_tag : std_logic_vector(16 downto 0);
signal s_index :std_logic_vector (8 DOWNTO 0); 
signal s_offset : std_logic_vector (5 DOWNTO 0); 

signal data: std_logic_vector(31 DOWNTO 0); 
signal hit_addr : std_logic;


type t_Memory is array (0 to 31) of std_logic_vector(31 downto 0);
signal mainmem : t_Memory:= ("00000000000000000000000000000001",others =>"00000000000000000000000000100000");

signal dirtys0 : t_Dirty:= ( others => '0');
signal valids0 : t_valid:= ( others => '0');
signal tags0 : t_tag:=( others => "00000000000000000");
signal lru0: t_LRU:=(others => '0'); 

signal dirtys1 : t_Dirty:= ( others => '0');
signal valids1 : t_valid:= (others => '0');
signal tags1 : t_tag:=( others => "00000000000000000");
signal lru1: t_LRU:=(others => '1'); 


signal miss : std_logic; 

BEGIN

process (clock)
	begin
	if clock = '1' then
		s_tag <= Address(31 DOWNTO 15); 
		s_index <= Address(14  DOWNTO 6); 
		s_offset <= Address(5  DOWNTO 0); 
		hit_addr <= '0'; 
		-- Hit logic
		if valids0(to_integer(unsigned(s_index))) = '1' or valids1(to_integer(unsigned(s_index))) = '1' then 
			if s_tag = tags0(to_integer(unsigned(s_index))) or s_tag = tags1(to_integer(unsigned(s_index))) then 
				data <= mainmem(to_integer(unsigned(s_offset))); 
				hit_addr <= '1'; 
				miss <= '0';
			end if; 
		else		 
		-- Miss logic
		-- Ver en que set va a ponerse el dato (si en el 0 o en el 1) 
			if lru0(to_integer(unsigned(s_index))) = '0' then
				-- En este caso se escoje el set 0 
				-- Llenar el arreglo de valid con '1' en la posicion del index 
				valids0(to_integer(unsigned(s_index))) <= '1';
				
				-- Poner el actual lru_0 bit en '1' y cambiar el otro a '0' en el index correspondiente 
				--lru0(to_integer(unsigned(s_index))) <= '1'; 
				--lru1(to_integer(unsigned(s_index))) <= '0'; 
				-- Guardar el tag en cache_0 
				cache0(to_integer(unsigned(s_index)))(to_integer(unsigned(s_index))) <= s_tag;

				-- Llenar el arreglo de tags con el tag correspondiente
				tags0(to_integer(unsigned(s_index))) <= s_tag;

				-- Hubo miss 
				miss <= '1'; 
				hit_addr <= '0'; 
			else
				-- En este caso se escoje el set 1 
				-- Llenar el arreglo de valid con '1' en la posicion del index 
				valids1(to_integer(unsigned(s_index))) <= '1';
				
				--- Poner el actual lru_0 bit en '1' y cambiar el otro a '0' en el index correspondiente 
				lru1(to_integer(unsigned(s_index))) <= '1'; 
				lru0(to_integer(unsigned(s_index))) <= '0'; 
				-- Guardar el tag en cache_0 
				cache1(to_integer(unsigned(s_index)))(to_integer(unsigned(s_index))) <= s_tag;

				-- Llenar el arreglo de tags con el tag correspondiente
				tags1(to_integer(unsigned(s_index))) <= s_tag;

				-- Hubo miss 
				miss <= '1'; 
				hit_addr <= '0'; 
			end if; 	
					
		end if; 	
	end if; 
end process;

	tag_out <= s_tag; 
	index_out <= s_index;
	offset_out <= s_offset;
	hit <= hit_addr; 
	data_out <= data;
	miss_out <= miss; 

END TypeArchitecture;
