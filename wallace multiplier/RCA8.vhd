--    Ripple Carry Adder
--            _______
--  A(7-0)->|       |
--  B(7-0)->|  RCA  |->S(7-0)
--     Cin->|_______|->Cout        
library ieee;
use ieee.std_logic_1164.all;

entity RCA8 is
	 Generic(
				constant Len : natural := 7);
     port(
			A, B :  in std_logic_vector(Len downto 0);
			Cin  :  in std_logic;
			S    : out std_logic_vector(Len downto 0);
			Cout : out std_logic);
end RCA8;

architecture STRUCTURAL of RCA8 is
	component FA is
	    port(
			X, Y, Ci  :   in std_logic;
			F, Co     : out std_logic);
	end component;
      signal Caux : std_logic_vector(Len downto 0);
begin
		FADD: FA port map (A(0),B(0),Cin,S(0),Caux(0));
		ADDER8:
		for i in 1 to Len generate
			FADD0: FA port map (A(i),B(i),Caux(i-1),S(i),Caux(i));
		end generate ADDER8;
		
      Cout <= Caux(Len);		
end STRUCTURAL;

