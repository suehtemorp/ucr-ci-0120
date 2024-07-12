--------------------------------------------------------------------------------
-- Project :
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
--
 --128KB 
-- Address are size 30
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE ieee.numeric_std.all;  


ENTITY Cache_instrucciones IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
 	clock      : IN  std_logic;           
	Address: IN std_logic_vector(29 DOWNTO 0);
  	Data_From_Mem: IN std_logic_vector(31 DOWNTO 0); 
  ------------------------------------------------------------------------------
	hit : OUT std_logic; 
	miss: OUT std_logic; 
	data: OUT std_logic_vector(31 DOWNTO 0);
	address_physical: OUT std_logic_vector(29 DOWNTO 0); 
tag_out : OUT std_logic_vector(12 downto 0); 
tag_from_cache : OUT std_logic_vector(12 DOWNTO 0)
    );
END Cache_instrucciones;


ARCHITECTURE TypeArchitecture OF Cache_instrucciones IS
-- Cache block definition: array of 2048 blocks of 32 bit words
type t_bloque is array(0 to 63) of std_logic_vector(31 downto 0);
type t_set is array(0 to 2048) of t_bloque;

signal cache0 : t_set;
type t_tag is array(0 to 2048) of std_logic_vector(12 downto 0);
type t_valid is array(0 to 2048) of std_logic;

signal valids0 : t_valid:= ( others => '0');
signal tags0 : t_tag:=( "0000000000000", others => "0000000000000");

signal s_tag : std_logic_vector(29 DOWNTO 17);
signal s_index :std_logic_vector (16 DOWNTO 6); 
signal s_offset : std_logic_vector (5 DOWNTO 0); 

-- Signal for miss and hit logic
signal miss_out : std_logic; 
signal hit_addr : std_logic;

signal data_out: std_logic_vector(31 DOWNTO 0); 

BEGIN
-- Process that handles the cache behavior on clock edge
process (clock)
	begin
	if clock = '1' then
		-- Extracting tag, index, and offset from the address when clock is in its positive state 
		s_tag    <= Address(29 DOWNTO 17); 
		s_index  <= Address(16 DOWNTO 6); 
		s_offset <= Address(5 DOWNTO 0); 
		-- Default values for hit and miss signals 
		hit_addr <= '0'; 
		miss_out <= '1'; 
		data_out <= x"00000000"; 
		if valids0(to_integer(unsigned(s_index))) = '1' then 
			data_out <= x"11111111";
			if s_tag = tags0(to_integer(unsigned(s_index))) then 
				-- If found, read data from cache memory
				data_out <= cache0(to_integer(unsigned(s_index)))(to_integer(unsigned(s_index)));
				hit_addr <= '1'; 
				miss_out <= '0';
			end if; 

		else 	
		 	hit_addr <= '0'; 
			miss_out <= '1';
			-- Miss, store data to cache 
			valids0(to_integer(unsigned(s_index))) <= '1';
			-- Save data in cache0
			cache0(to_integer(unsigned(s_index)))(to_integer(unsigned(s_index))) <= Data_From_Mem;
			data_out <= x"aaaabbbb";
			-- Add the tag to tags0 
			tags0(to_integer(unsigned(s_index))) <= s_tag;
			--tag_from_cache <= s_tag;
			address_physical <= Address;
		end if;
	end if; 

end process;
hit <= hit_addr; 
miss <= miss_out; 
data <= data_out; 
tag_out <= s_tag;
tag_from_cache <= s_tag;

END TypeArchitecture;
