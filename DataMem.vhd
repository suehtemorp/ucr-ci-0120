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

ENTITY DataMem IS
  PORT (
 
  ------------------------------------------------------------------------------

    clock			: IN  std_logic;                   
    address		: IN  std_logic_vector(7 DOWNTO 0); 
    write_data      : IN  std_logic_vector(7 DOWNTO 0); 
    MemRead		: IN std_logic; 
    MemWrite        : IN std_logic;
    
  ------------------------------------------------------------------------------

	read_data1	: OUT std_logic_vector(7 DOWNTO 0)  -- output bit example
	
    );

END DataMem;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF DataMem IS

type t_Memory is array (0 to 7) of std_logic_vector(7 downto 0);
signal cache : t_Memory:= (x"ff",x"f1",x"f2", x"f3",others =>x"00");
 --initialization of the register file of different values 

signal data : std_logic_vector(7 DOWNTO 0);


BEGIN
process (clock)
	begin
	if rising_edge(clock) then
		if (MemWrite='1') then
			cache(to_integer(unsigned(address)))<=write_data;
		else
			--
		end if;
	data <= cache(to_integer(unsigned(address)));
	
	else
 
		--	
	end if;
	end process;
-----------------------------------	
	 read_data1 <= data;


END TypeArchitecture;
