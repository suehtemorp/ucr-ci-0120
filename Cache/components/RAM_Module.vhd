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

ENTITY RAM_Module IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
	clock: IN std_logic;
    write : IN std_logic; 
    read: IN std_logic; 
    offset: IN std_logic_vector(5 DOWNTO 0); 
  ------------------------------------------------------------------------------
  --Insert output ports below
    data        : OUT std_logic_vector(31 DOWNTO 0)                    -- output bit example
    );
END RAM_Module;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF RAM_Module IS

-- Main memory definition: array of 32 words of 32 bits
type t_Memory is array (0 to 63) of std_logic_vector(31 downto 0);
signal mainmem : t_Memory:= (x"12345678",x"1241a393",others=>x"aaaabbbb");


BEGIN
process (clock)
begin
	if clock = '1' then
		if read = '1' then
			data <= mainmem(to_integer(unsigned(offset))); 
		end if;
	end if;  
end process; 
END TypeArchitecture;
