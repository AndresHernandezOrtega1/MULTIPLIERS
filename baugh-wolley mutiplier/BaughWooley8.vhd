----------------------------------------------------------------------------
-------    Multiplicador de Baugh Wooley de 8 bits   		----------------
----------------------------------------------------------------------------
--  		           _______
--			 		  |        |
--		 	  A(7-0)->| Baugh  |->S(15-0)
--			  B(7-0)->| Wooley |
--			     	  |________|
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BaughWooley8 is
	generic(constant Len: natural := 8);	
	port (
        A: in  std_logic_vector (Len-1 downto 0);--Multiplicando
        B: in  std_logic_vector (Len-1 downto 0);--Multiplicador
        X: out std_logic_vector (2*Len-1 downto 0)--Resultado
	);
end BaughWooley8;


architecture structural of BaughWooley8 is
	--Definición de matrices de señales
	type matrix1 is array (0 to Len) of std_logic_vector(Len-1 downto 0);
	type matrix is array (0 to Len-1) of std_logic_vector(Len-1 downto 0);
	type matrix2 is array (0 to Len+1) of std_logic_vector(Len downto 0);
	signal M : matrix:=(others=>(others=>'0'));--A(i) AND B(i) not(A(i) AND B(i))
	signal C: matrix1:=(others=>(others=>'0'));--Matriz de acarreos 
	signal P: matrix2:=(others=>(others=>'0'));--Matriz de Sumas Full_Adder
	signal Co: std_logic;					   --Necesaria para usar RCA de 8 bits
	
	component RCA8 is			--RCA de 8 bits
	  port( A, B :  in std_logic_vector(Len-1 downto 0);--IN de 8 bits
			  Cin  :  in std_logic;						--OUT de 8 bits
			  S    : out std_logic_vector(Len-1 downto 0);--Suma de 8 bits
			  Cout : out std_logic);					--Acarreo de Salida
	end component;
	
	component FA is--Sumador completo de 1 solo bit
	port(X,Y,Ci: in std_logic;--Se tienen las entradas X, Y, Si y acarreo de entrada
		Co,F:out std_logic); --Resultado de la suma y Acarreo de Salida
	end component;
	
begin
	M(Len-1)(Len-1)<=A(Len-1) and B(Len-1);--Calculo señal (7,7)
	P(Len)(Len)<='1';	--Se incluye en la suma del MSB
	
	PROD:
	for i in 0 to Len-1 generate
		P(i)(Len)<='0';--Carga señales iniciales como '0'
	end generate PROD;
	
	--Cálculo de señales AND o NAND de las casilla de los FA
	FILAS:	
	for row in 0 to Len-1 generate
		COLUMNAS:
		for col in Len-1 downto 0 generate
		  PR:if(row=Len-1 or col=Len-1) generate
			 PR1:if(row/=col) generate
					M(row)(col)<=not(A(col) and B(row));
				  end generate PR1;
			 end generate PR;
		  PR3:if(row/=Len-1 and col/=Len-1) generate
				  M(row)(col)<=A(col) and B(row);			
			   end generate PR3;			
		 end generate COLUMNAS;
	end generate FILAS;
	
	--Generación de matriz de Full adders 8x8
	FILAS1:	
	for row in 0 to Len-1 generate
		COLUMNAS1:
		for col in Len-1 downto 0 generate
					FADDER: FA port map(P(row)(col+1),M(row)(col),C(row)(col),C(row+1)(col),P(row+1)(col));
		end generate;
	end generate;
	--Sumador RCA de 8 bits para completar resultado anterior
	RCA8bits: RCA8 port map(P(Len)(Len downto 1),C(Len),'1',P(Len+1)(Len-1 downto 0),Co);
	--Mapeo de buffer en el puerto de salida
	X(2*Len-1 downto Len)<=P(Len+1)(Len-1 downto 0);
	
	XProd:
	for i in 0	to Len-1 generate
		X(i)<=P(i+1)(0);--Mapeo puertos de salida 0 a 7
   end generate;
	
end structural;