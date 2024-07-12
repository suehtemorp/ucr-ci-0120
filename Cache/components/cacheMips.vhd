--------------------------------------------------------------------------------
-- Description :
-- Cache for pipelined MIPS processor. 
-- 2 way associative.
-- 32 bit addresses and 32 bit data output. 
-- Address is divided this way: 
--  tag is of 17 bits, index is of 8 bits and offset is 5 bits. 
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE ieee.numeric_std.all;  

ENTITY cacheMips IS
  PORT (
  ------------------------------------------------------------------------------
  -- Input ports
    clock      : IN  std_logic;           
    Address: IN std_logic_vector(31 DOWNTO 0);
    Data_From_Mem: IN std_logic_vector(31 DOWNTO 0); 
    write_cache: IN std_logic; 
    entrada_dato: IN std_logic_vector(31 DOWNTO 0); 

  ------------------------------------------------------------------------------
  -- Output ports
	hit : OUT std_logic; 
	data: OUT std_logic_vector(31 DOWNTO 0);
	miss: OUT std_logic; 
	offset: OUT std_logic_vector(5 DOWNTO 0)
    );
END cacheMips;

--------------------------------------------------------------------------------
-- Architecture of the cacheLRU entity
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF cacheMips IS

-- Cache block definition: array of 64 blocks of 20-bit words
type bloque is array(0 to 63) of std_logic_vector(20 downto 0);

-- Cache set definition: array of 256 cache blocks
type t_set is array(0 to 255) of bloque;

-- Two sets for the 2-way associative cache
signal cache0 : t_set;
signal cache1 : t_set; 

-- Tag, valid, dirty, and LRU signal definitions
type t_tag is array(0 to 255) of std_logic_vector(20 downto 0);
type t_valid is array(0 to 255) of std_logic;
type t_Dirty is array(0 to 255) of std_logic;
type t_LRU is array(0 to 255) of std_logic; 

-- Internal signals for tag, index, offset, and data
signal s_tag : std_logic_vector(20 downto 0);
signal s_index :std_logic_vector (4 DOWNTO 0); 
signal s_offset : std_logic_vector (5 DOWNTO 0); 
signal data_out: std_logic_vector(31 DOWNTO 0); 
signal hit_addr : std_logic;

-- Main memory definition: array of 32 words of 32 bits
type t_Memory is array (0 to 31) of std_logic_vector(31 downto 0);
signal mainmem : t_Memory:= ("00000000000000000000000000000001",others =>"00000000000000000000000000100000");

-- Signals for dirty, valid, tag, and LRU bits for both cache sets
signal dirtys0 : t_Dirty:= ( others => '0');
signal valids0 : t_valid:= ( others => '0');
signal tags0 : t_tag:=( others => "000000000000000000000");
signal lru0: t_LRU:=(others => '0'); 

signal dirtys1 : t_Dirty:= ( others => '0');
signal valids1 : t_valid:= (others => '0');
signal tags1 : t_tag:=( others => "000000000000000000000");
signal lru1: t_LRU:=(others => '1'); 

-- Signal for miss logic
signal miss_out : std_logic; 

signal set_0_out: std_logic;
signal set_1_out : std_logic; 



BEGIN
-- Process that handles the cache behavior on clock edge
process (clock)
	begin
	if clock = '1' then
	-- Extracting tag, index, and offset from the address when clock is in its positive state 
		s_tag <= Address(31 DOWNTO 11); 
		s_index <= Address(10  DOWNTO 6); 
		s_offset <= Address(5  DOWNTO 0); 
		-- Default values for hit and miss signals 
		hit_addr <= '0'; 
		miss_out <= '1'; 

		-- Check if the address is in the cache (this is when valid bit and tag match) 
		if valids0(to_integer(unsigned(s_index))) = '1' or valids1(to_integer(unsigned(s_index))) = '1' then 
			if s_tag = tags0(to_integer(unsigned(s_index))) or s_tag = tags1(to_integer(unsigned(s_index))) then 
				-- If found, read data from main memory
				data_out <= Data_From_Mem;
				hit_addr <= '1'; 
				miss_out <= '0';
			end if; 
		end if; 
		-- Determine which set to used based on LRU bit. Check if the tag is not stored already in the cache 
		if lru0(to_integer(unsigned(s_index))) = '0'and tags1(to_integer(unsigned(s_index))) /= s_tag  then 

				-- Use set 0 
				valids0(to_integer(unsigned(s_index))) <= '1';
				
				-- Actual lru_0 bit changes to '1' and the other lru_1 bit changes to '0' in the index from address.  
				lru0(to_integer(unsigned(s_index))) <= '1'; 
				lru1(to_integer(unsigned(s_index))) <= '0';
				
				-- Save tag in cache0
				cache0(to_integer(unsigned(s_index)))(to_integer(unsigned(s_offset))) <= s_tag;

				-- Add the tag to tags0 
				tags0(to_integer(unsigned(s_index))) <= s_tag;

		elsif lru1(to_integer(unsigned(s_index))) = '0' and tags0(to_integer(unsigned(s_index))) /= s_tag then 
				-- Use set 1 
				valids1(to_integer(unsigned(s_index))) <= '1';
				
				-- Actual lru_1 bit changes to '1' and the other lru_0 bit changes to '0' in the index from address.  
				lru1(to_integer(unsigned(s_index))) <= '1'; 
				lru0(to_integer(unsigned(s_index))) <= '0'; 
				-- Save tag in cache1
				cache1(to_integer(unsigned(s_index)))(to_integer(unsigned(s_offset))) <= s_tag;

				-- Add the tag to tags1
				tags1(to_integer(unsigned(s_index))) <= s_tag;

		end if;
	end if; 
end process;

	-- Assign internal signals to output ports 

	hit <= hit_addr; 
	data <= data_out;
	miss <= miss_out; 
	offset <= s_offset;

END TypeArchitecture;
