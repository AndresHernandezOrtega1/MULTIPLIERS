
library  ieee;
use ieee.std_logic_1164.all;

entity HA is--Sumador completo de 1 solo bit
	port(X,Y: in std_logic;--Se tienen las entradas X, Y, Si y acarreo de entrada
		Co,F:out std_logic); --Resultado de la suma y Acarreo de Salida
end HA;

architecture RTL of HA is
	signal G, P: std_logic; --Señal generadora y habilitador de propagación
	begin
		G <= X and Y;			 
		P <= X xor Y;
		F <= P ;
		Co<= G ;
end RTL;
