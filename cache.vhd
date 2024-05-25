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

ENTITY cache IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    clock      : IN  std_logic;                    -- input bit example
    Address: IN std_logic_vector(25 DOWNTO 0); -- tag(11) + index(9) + offset(6)
--25...15  14...6   5...0       como indexar bits?
  --tag  --index  --Offset      
  ------------------------------------------------------------------------------
  --Insert output ports below
  tag_out : OUT std_logic_vector(10 DOWNTO 0); 
  index_out : OUT std_logic_vector(8 downto 0);
  offset_out: OUT std_logic_vector(5 downto 0) 
    );
END cache;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF cache IS
alias tag is Address(25 downto 15);
alias index is Address(14 downto 6);
alias offset is Address(5 downto 0);


signal t : std_logic_vector(25 downto 15);
signal i : std_logic_vector(14 downto 6);
signal o : std_logic_vector(5 downto 0);
BEGIN


process (clock)
	begin
	if rising_edge(clock) then
		t <= tag; 
		i <= index; 
		o <= offset; 
	
	else
 
		--	
	end if;
	end process;
			tag_out <= t; 
		index_out <= i; 
		offset_out <= o; 
END TypeArchitecture;
