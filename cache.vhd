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

ENTITY cache IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    clock      : IN  std_logic;           
    Address: IN std_logic_vector(25 DOWNTO 0);

  ------------------------------------------------------------------------------
	hit : OUT std_logic; 
	data_out: OUT std_logic_vector(5 DOWNTO 0);
		tag_out : OUT std_logic_vector (10 DOWNTO 0); 
		index_out : OUT std_logic_vector (8 DOWNTO 0); 
		offset_out :OUT std_logic_vector (5 DOWNTO 0)
    );
END cache;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF cache IS

type bloque is array(0 to 8) of std_logic_vector(7 downto 0);
type t_set is array(0 to 16) of bloque;
signal cache0 : t_set;

type t_tag is array(0 to 16) of std_logic_vector(10 downto 0);

type t_valid is array(0 to 16) of std_logic;

type t_Dirty is array(0 to 16) of std_logic;



signal s_tag : std_logic_vector(10 downto 0);
signal s_index :std_logic_vector (8 DOWNTO 0); 
signal s_offset : std_logic_vector (5 DOWNTO 0); 

signal data: std_logic_vector(5 DOWNTO 0); 
signal hit_addr : std_logic;

-- TODO: add main memory preguntar como funciona el offset 
type t_Memory is array (0 to 31) of std_logic_vector(5 downto 0);
signal mainmem : t_Memory:= ("000100","000011","000010", "000001", "001000",others =>"000000");

signal dirtys : t_Dirty;
signal valids : t_valid:= ('1', '1','1','1', others => '1');
signal tags : t_tag:=("10000000000", others => "00000000000");

BEGIN

process (clock)
	begin
	if clock = '1' then
		s_tag <= Address(25 DOWNTO 15); 
		s_index <= Address(14  DOWNTO 6); 
		s_offset <= Address(5  DOWNTO 0); 

		if valids(to_integer(unsigned(s_index))) = '1' then 
			if s_tag = tags(to_integer(unsigned(s_index))) then 
				data <= mainmem(to_integer(unsigned(s_offset))); 
				hit_addr <= '1'; 
			end if; 
		else 
			hit_addr <= '0'; 
			data <= "000000"; 
		end if; 
		
	end if; 
end process;

	tag_out <= s_tag; 
	index_out <= s_index;
	offset_out <= s_offset;
	hit <= hit_addr; 
	data_out <= data;

END TypeArchitecture;
