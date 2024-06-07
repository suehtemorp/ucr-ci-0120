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

ENTITY classCache IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    clock      : IN  std_logic;           
    Address: IN std_logic_vector(31 DOWNTO 0);

  ------------------------------------------------------------------------------
	hit : OUT std_logic; 
	data_out: OUT std_logic_vector(31 DOWNTO 0);
		tag_out : OUT std_logic_vector (10 DOWNTO 0); 
		index_out : OUT std_logic_vector (8 DOWNTO 0); 
		offset_out :OUT std_logic_vector (5 DOWNTO 0);
	miss_out: OUT std_logic
    );
END classCache;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF classCache IS

type bloque is array(0 to 63) of std_logic_vector(10 downto 0);
type t_set is array(0 to 255) of bloque;
signal cache0 : t_set;
signal cache1 : t_set; 

type t_tag is array(0 to 255) of std_logic_vector(10 downto 0);

type t_valid is array(0 to 255) of std_logic;

type t_Dirty is array(0 to 255) of std_logic;



signal s_tag : std_logic_vector(10 downto 0);
signal s_index :std_logic_vector (8 DOWNTO 0); 
signal s_offset : std_logic_vector (5 DOWNTO 0); 

signal data: std_logic_vector(31 DOWNTO 0); 
signal hit_addr : std_logic;


type t_Memory is array (0 to 31) of std_logic_vector(31 downto 0);
signal mainmem : t_Memory:= ("00000000000000000000000000000001",others =>"00000000000000000000000000100000");

signal dirtys0 : t_Dirty;
signal valids0 : t_valid:= ('1', '0','0','0', others => '0');
signal tags0 : t_tag:=("10000000000", others => "00000000000");

signal dirtys1 : t_Dirty;
signal valids1 : t_valid:= ('1', '0','0','0', others => '0');
signal tags1 : t_tag:=("10000000000", others => "00000000000");

signal miss : std_logic; 

BEGIN

process (clock)
	begin
	if clock = '1' then
		s_tag <= Address(25 DOWNTO 15); 
		s_index <= Address(14  DOWNTO 6); 
		s_offset <= Address(5  DOWNTO 0); 
		hit_addr <= '0'; 
		if valids0(to_integer(unsigned(s_index))) = '1' or valids1(to_integer(unsigned(s_index))) = '1' then 
			if s_tag = tags0(to_integer(unsigned(s_index))) or s_tag = tags1(to_integer(unsigned(s_index))) then 
				data <= mainmem(to_integer(unsigned(s_offset))); 
				hit_addr <= '1'; 
				miss <= '0';
			end if; 
		else 
			hit_addr <= '0'; 
			if s_tag(0) = '0' then
				cache0(to_integer(unsigned(s_index)))(to_integer(unsigned(s_index))) <= s_tag;
				dirtys0(to_integer(unsigned(s_index))) <= '1'; 
				valids0(to_integer(unsigned(s_index))) <= '1';
				tags0(to_integer(unsigned(s_index))) <= s_tag;
			else
				cache1(to_integer(unsigned(s_index)))(to_integer(unsigned(s_index))) <= s_tag;
				dirtys1(to_integer(unsigned(s_index))) <= '1'; 
				valids1(to_integer(unsigned(s_index))) <= '1';
				tags1(to_integer(unsigned(s_index))) <= s_tag;
			end if; 
			miss <= '1'; 
			hit_addr <= '0'; 
			
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
