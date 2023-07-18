library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity wallace8_tb is end entity; 
architecture Test of wallace8_tb is
constant MiN : natural:=to_integer(unsigned'(x"FA")); 
constant Max : natural:=to_integer(unsigned'(x"FF")); 
constant prueba : natural:=to_integer(unsigned'(x"AA")); 
signal sA, sB : std_logic_vector(7 downto 0); 
signal sX : std_logic_vector(15 downto 0); 
begin 
DUT: entity work.wallace8 port map (sA,sB,sX); 
TB2: process begin 
for ind in 0 to 15 loop 
sA <= std_logic_vector(to_unsigned(ind,16)); 
sB <= std_logic_vector(to_unsigned(2*ind,16)); 
wait for 100 ns; end loop; 
for i in Min to Max loop 
sA <= std_logic_vector(to_unsigned(i,16)); 
sB <= std_logic_vector(to_unsigned(prueba,16)); 
wait for 100 ns; end loop; 
wait; 
end process; end Test; 