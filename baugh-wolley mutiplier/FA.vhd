--   Full Adder Modificado And
--           _______
--  	 X->|       |
--       Y->| FULL  |->F
--      Ci->| ADDER |->Co        
--          |_______|        
--
library  ieee;
use ieee.std_logic_1164.all;

entity FA is--Sumador completo de 1 solo bit
	port(X,Y,Ci: in std_logic;--Se tienen las entradas X, Y, Si y acarreo de entrada
		Co,F:out std_logic); --Resultado de la suma y Acarreo de Salida
end FA;

architecture RTL of FA is
	signal G, P: std_logic; --Señal generadora y habilitador de propagación
	begin
		G <= X and Y;			 
		P <= X xor Y;
		F <= P xor Ci;
		Co <= G or(P and Ci);
end RTL;
