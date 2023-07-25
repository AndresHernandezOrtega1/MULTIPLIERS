library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity boothMult is
	generic (	nBits : integer := 8
				);
	port	(	A : in	std_logic_vector(nBits-1 downto 0); 		--Multiplicando
				B : in	std_logic_vector(nBits-1 downto 0);  		--Multiplicador
				P : out std_logic_vector(2*(nBits)-1 downto 0)		--resultado
			);
end entity boothMult;

architecture MIXED of boothMult is

	--Componente generador del complemento a 2
	component twoComplGen
		generic(n : integer := 8);
		port(
			A : in  std_logic_vector(n+(n-1)*2 downto 0);
			Z : out std_logic_vector(n+(n-1)*2 downto 0)
		);
	end component twoComplGen;
	--Componente generador de multiplexores de operaciones
	component MUX51_generic
		generic(n : integer := 8);
		port(
			A   : in  std_logic_vector(n-1 downto 0);
			B   : in  std_logic_vector(n-1 downto 0);
			C   : in  std_logic_vector(n-1 downto 0);
			D   : in  std_logic_vector(n-1 downto 0);
			E   : in  std_logic_vector(n-1 downto 0);
			sel : in  std_logic_vector(2 downto 0);
			Y   : out std_logic_vector(n-1 downto 0)
		);
	
	end component MUX51_generic; 
	
	component RCA
		generic(n : integer := 8);
		port(
			A  : in  std_logic_vector(n-1 downto 0);
			B  : in  std_logic_vector(n-1 downto 0);
			Ci : in  std_logic;
			S  : out std_logic_vector(n-1 downto 0);
			Co : out std_logic
		);
	end component RCA;
	
	component boothEnc
		generic(n : integer := 8);
		port(
			B : in  std_logic_vector(n-1 downto 0);
			Y : out std_logic_vector(3*(n/2)-1 downto 0)
		);
	end component boothEnc;
	
	constant encbits : integer := 3*(nBits/2);
	
	type add_o is array (0 to (nBits/2-2)) of std_logic_vector(2*(nBits)-1 downto 0); -- los sumadores la salida es una matriz tiene N/2 -1 filas y 2N columnas que son igual a los numeros de la entrada de datos
	
	type mux_s is array (0 to (nBits/2-1)) of std_logic_vector(2 downto 0);					 -- Los seleccionadores de multiplexores son una matris que tiene(N/2)-1 filas que corresponden al numero de mux
																														 -- y  3 columnas que son iguales al numero exacto de bits necesarios para cada grupo.
	type mux_o is array (0 to (nBits/2-1)) of std_logic_vector(2*(nBits)-1 downto 0); -- las salidas de mux (N/2)-1 filas corresponde a la entrada
																														 
	
	signal add_out	: add_o;
	signal mux_sel	: mux_s;
	signal mux_out	: mux_o;
	
	-- los siguientes vectores tienen el tamaño para permitir el desplazamiento de los bits de entrada siempre y cuando sea necesario
	signal mData: std_logic_vector(nBits+(nBits-1)*2 downto 0); 	
	signal twoCdata: std_logic_vector(nBits+(nBits-1)*2 downto 0);
	
	signal enc_out	: std_logic_vector(encbits-1 downto 0); -- the enc_out signal is a vector sized with encbits, which correspond to 3*(N/2) 
	
	begin

	-- instacia del complemento a 2
	twoCompl : twoComplGen
		generic map	(
					n => nBits
		)
		port map (
					A => mData,
					Z => twoCdata	-- data de complemento a dos
				 );
	
	mData(3*nBits-2 downto 2*nBits-1) <= (others => '0');	--	inicializador de datos con clear a 0 
	mData((nBits-1)*2 downto nBits-1) <= A;	--	Luego de inicializar se le asignan los valores de la entrada A
	mData(nBits-2 downto 0) <= (others => '0');	--	Asigna los bits restantes  a 0 el numero de ceros son los corrimientos máximos posibles

	-- Inicialización del enconder de Booth y conexión de la data de B 
		enc : boothEnc
		generic map(
			n => nBits
		)
		port map(
			B => B,
			Y => enc_out
		);
	--el siguiente for generate conecta la señal de salida del encoder a un multiplexor de selección Mux_sel que es de la matriz
	-- El selector es escencial para seleccionar el multiplexor adecuado

	forENCconn : for i in 0 to (nBits/2-1)  generate	-- de 0 al maximo de mux necesarios
	begin																	
		mux_sel(i) <= enc_out(3*i+2 downto 3*i);				--toma 3 bits de Enc_out en cada iteración de este modo el mux de selección tiene 3 bits para cada fila  
	end generate;
	
	-- este for generate inicializa N/2 mux y los conecta a los datos correctos
	mux_gen: for i in 0 to (nBits/2-1) generate
	begin
		mux: MUX51_generic 
			
			generic map(
						n => 2*nBits
			)															   
			port map(	A => (OTHERS => '0'),	-- dato enclavado a 0 siempre
						B => mData(3*nBits-2-2*i downto nBits-1-2*i),	-- en cada iteración asigna la entrada A por primera vez, y la versión multiplicada de las siguientes iteraciones, con respecto al numero de bits de datos
						C => twoCdata(3*nBits-2-2*i downto nBits-1-2*i), -- cada iteración asigna el complemento a dos de la entrada A y lo multiplica para las siguientes iteraciones con respecto al numero de bits de datos
						D => mData(3*nBits-2-2*i-1 downto nBits-1-2*i-1),	-- cada iteración, asigna  la  entrada A multiplicada por 2 o con un corrimiento de un bit que es lo mismo comparada con la entrada B	
						E => twoCdata(3*nBits-2-2*i-1 downto nBits-1-2*i-1), -- -- repite el ciclo y asigna el complemento a dos de A multiplicada por 2 (corriemiento de 1 bit) comparado con la entrada B 
						sel => mux_sel(i),	-- conecta el seleccionador del mux con la señal fila por fila
						Y => mux_out(i));		-- conecta la salida del mux con la señal de salida fila por fila
						
	end generate mux_gen;
	
	--  1 RCA y conexión de las salidas de los mux a las entradas del RCA 
	sum1 : RCA
		   generic map(
		   			n => 2*nBits
		   )
		   port map(
					A => mux_out(1),	-- conecta la entrada del RCA A al primer mux de salida 
					B => mux_out(0),	-- conecta  la entrada del RCA B al segundo mux de salida
		   			Ci => '0',
		   			S => add_out(0),	-- conecta la salida del RCA S al primer elemento de la matriz
					Co => open			
		   );
		   
	-- parte que conecta los RCA de la primera etapa con la siguiente etapa de operación 		
	forsumi : for i in 1 to (nBits/2-2) generate
	sumi :	RCA
			generic map(
					n => 2*nBits
			)
			port map(
					A  => mux_out(i+1),	-- coneta la entrada  del RCA A al mux de salida it connects the A RCA input to the mux_out signal
					B  => add_out(i-1),	-- conecta la entrada del RCA B al segundo mux de salida en la siguiente iteración
					Ci => '0',
					S  => add_out(i),
					Co => open				
			);	
	end generate;
	
	P <= add_out(nBits/2-2);		-- se toma el ultimo elemento fila de la matriz add_out  We take the last element(last row) para ver el resultado 
	
end architecture MIXED;