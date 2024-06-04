library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cache is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        address : in std_logic_vector(31 downto 0);
        write_data : in std_logic_vector(31 downto 0);
        write_enable : in std_logic;
        read_data : out std_logic_vector(31 downto 0);
        hit : out std_logic
    );
end cache;

architecture Behavioral of cache is
    -- Cache parameters
    constant CACHE_SIZE : integer := 256;  -- Number of sets
    constant ASSOCIATIVITY : integer := 2; -- 2-way associative

    -- Type declarations
    type cache_line is record
        valid : std_logic;
        tag : std_logic_vector(23 downto 0);
        data : std_logic_vector(31 downto 0);
    end record;

    type cache_set is array (0 to ASSOCIATIVITY-1) of cache_line;
    type cache_array is array (0 to CACHE_SIZE-1) of cache_set;

    -- Cache memory
    signal cache : cache_array := (others => (others => (valid => '0', tag => (others => '0'), data => (others => '0'))));

    -- Internal signals
    signal index : integer range 0 to CACHE_SIZE-1;
    signal tag : std_logic_vector(23 downto 0);
    signal offset : std_logic_vector(1 downto 0);
    signal hit_way : integer range 0 to ASSOCIATIVITY-1;
    signal found : std_logic;
    signal way : integer range 0 to ASSOCIATIVITY-1;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            for i in 0 to CACHE_SIZE-1 loop
                for j in 0 to ASSOCIATIVITY-1 loop
                    cache(i)(j).valid <= '0';
                    cache(i)(j).tag <= (others => '0');
                    cache(i)(j).data <= (others => '0');
                end loop;
            end loop;
            read_data <= (others => '0');
            hit <= '0';

        elsif rising_edge(clk) then
            -- Extract index, tag, and offset from address
            index <= conv_integer(address(31 downto 24));   -- 8-bit index
            tag <= address(23 downto 0);			     -- 24-bit index
            offset <= address(1 downto 0);				-- 2-bit offset

            -- Check for cache hit
            found <= '0';
            for way in 0 to ASSOCIATIVITY-1 loop
                if cache(index)(way).valid = '1' and cache(index)(way).tag = tag then
                    found <= '1';
                    hit_way <= way;
                end if;
            end loop;

            if found = '1' then
                -- Cache hit
                hit <= '1';
                read_data <= cache(index)(hit_way).data;
                if write_enable = '1' then
                    cache(index)(hit_way).data <= write_data;
                end if;
            else
                -- Cache miss
                hit <= '0';
                read_data <= (others => '0');
                -- Write operation (if enabled)
                if write_enable = '1' then
                    cache(index)(0).valid <= '1';  -- Simple policy: replace way 0
                    cache(index)(0).tag <= tag;
                    cache(index)(0).data <= write_data;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
