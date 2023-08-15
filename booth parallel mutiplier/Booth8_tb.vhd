--Testbench Booth 8 bits    
--**********************************************************************************************************************
--Baugh-Wooley Multiplier test bench
--Authors:
--  Andres Gonzalo Hernandez Ortega
--  Braian Stiven Avella Rivera
--Year: 2023
--Maestría en Ingeniería
--Universidad Pedagogica y Tecnologica de Colombia
--
--TOP LEVEL
--
--Inputs:
--    A (required), B (required),
--    *** Warning: Inputs should be in 8 Bit format ***
--Outputs:
--    X (result)
--    *** Warning: The results will be given 16 bit format ***
--
--Description:
--This algorithm multiplied two numbers of 8-bit
--This implementation uses Booth Algorithm


--**********************************************************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BaughWooley8_tb is
end entity;

architecture Test of BaughWooley8_tb is
constant MiN : natural:=to_integer(unsigned'(x"7E"));
constant Max : natural:=to_integer(unsigned'(x"84"));
constant prueba : natural:=to_integer(unsigned'(x"AA"));
signal sA, sB : std_logic_vector(7 downto 0);
signal sX : std_logic_vector(15 downto 0);

component BaughWooley8 is
	  port ( A: in std_logic_vector(7 downto 0); -- multiplicand
			 B: in std_logic_vector(7 downto 0); -- multiplier
			 X: out std_logic_vector(15 downto 0)); -- result
end component;
 
begin
	DUT: BaughWooley8 port map (sA,sB,sX);
	TB2: process
	begin
		for ind in 5 to 15 loop	
			sA <= std_logic_vector(to_signed(ind,8));
			sB <= std_logic_vector(to_signed(2*ind,8));
			wait for 100 ns;
		end loop;
		
		for i in Min to Max loop		
			sA <= std_logic_vector(to_signed(i,8));
			sB <= std_logic_vector(to_signed(prueba,8));
			wait for 100 ns;
		end loop;
	wait;
	end process;
end Test;
