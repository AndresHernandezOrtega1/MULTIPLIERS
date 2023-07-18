




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity wallace8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
        B : in STD_LOGIC_VECTOR (7 downto 0);
        X : out STD_LOGIC_VECTOR (15 downto 0));
end wallace8;

architecture Behavioral of wallace8 is
signal sA, sB : std_logic_vector(7 downto 0); 
signal sX : std_logic_vector(15 downto 0); 
component FA is
    Port ( X : in STD_LOGIC;
        Y : in STD_LOGIC;
        Ci : in STD_LOGIC;
        F : out STD_LOGIC;
        Co : out STD_LOGIC);
end component;

component HA is
    Port ( X : in STD_LOGIC;
        Y : in STD_LOGIC;
        F : out STD_LOGIC;
        Co : out STD_LOGIC);
end component;

signal s00,s01,s02,s03,s04,s05,s06,s07,s10,s11,s12,s13,s14,s15,s16,s17,s20,s21,s22,s23,s24,s25,s26,s27,s30,s31,s32,s33,s34,s35,s36,s37,s40,s41,s42,s43,s44,s45,s46,s47,s50,s51,s52,s53,s54,s55,s56,s57,s60,s61,s62,s63,s64,s65,s66,s67,s70,s71,s72,s73,s74,s75,s76,s77:std_logic;
signal R01,R02,R03,R04,R05,R06,R07,R08,R09,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21,R22,R23,R24,R25,R26,R27,R28,R29,R30,R31,R32,R33,R34,R35,R36,R37,R38,R39,R40,R41,R42,R43,R44,R45,R46,R47,R48,R49,R50,R51,R52,R53,R54,R55,R56,R57,R58,R59,R60,R61,R62,R63,R64,R65,R66,R67,R68:std_logic;
signal c01,c02,c03,c04,c05,c06,c07,c08,c09,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,c50,c51,c52,c53,c54,c55,c56,c57,c58,c59,c60,c61,c62,c63,c64,c65,c66,c67,c68:std_logic;
begin

s00 <= A(0) and B(0);
s10 <= A(1) and B(0);
s20 <= A(2) and B(0);
s30 <= A(3) and B(0);
s40 <= A(4) and B(0);
s50 <= A(5) and B(0);
s60 <= A(6) and B(0);
s70 <= A(7) and B(0);
s01 <= A(0) and B(1);
s11 <= A(1) and B(1);
s21 <= A(2) and B(1);
s31 <= A(3) and B(1);
s41 <= A(4) and B(1);
s51 <= A(5) and B(1);
s61 <= A(6) and B(1);
s71 <= A(7) and B(1);
s02 <= A(0) and B(2);
s12 <= A(1) and B(2);
s22 <= A(2) and B(2);
s32 <= A(3) and B(2);
s42 <= A(4) and B(2);
s52 <= A(5) and B(2);
s62 <= A(6) and B(2);
s72 <= A(7) and B(2);
s03 <= A(0) and B(3);
s13 <= A(1) and B(3);
s23 <= A(2) and B(3);
s33 <= A(3) and B(3);
s43 <= A(4) and B(3);
s53 <= A(5) and B(3);
s63 <= A(6) and B(3);
s73 <= A(7) and B(3);
s04 <= A(0) and B(4);
s14 <= A(1) and B(4);
s24 <= A(2) and B(4);
s34 <= A(3) and B(4);
s44 <= A(4) and B(4);
s54 <= A(5) and B(4);
s64 <= A(6) and B(4);
s74 <= A(7) and B(4);
s05 <= A(0) and B(5);
s15 <= A(1) and B(5);
s25 <= A(2) and B(5);
s35 <= A(3) and B(5);
s45 <= A(4) and B(5);
s55 <= A(5) and B(5);
s65 <= A(6) and B(5);
s75 <= A(7) and B(5);
s06 <= A(0) and B(6);
s16 <= A(1) and B(6);
s26 <= A(2) and B(6);
s36 <= A(3) and B(6);
s46 <= A(4) and B(6);
s56 <= A(5) and B(6);
s66 <= A(6) and B(6);
s76 <= A(7) and B(6);
s07 <= A(0) and B(7);
s17 <= A(1) and B(7);
s27 <= A(2) and B(7);
s37 <= A(3) and B(7);
s47 <= A(4) and B(7);
s57 <= A(5) and B(7);
s67 <= A(6) and B(7);
s77 <= A(7) and B(7);


--Etapa 1
ha00: HA port map(s01,s10,R01,c01);
fa00: FA port map(s20,s02,s11,R02,c02);
fa01: FA port map(s30,s21,s12,R03,c03);
fa02: FA port map(s40,s31,s22,R04,c04);
ha01: HA port map(s13,s04,R05,c05);
fa03: FA port map(s50,s41,s32,R06,c06);
fa04: FA port map(s23,s14,s05,R07,c07);
fa05: FA port map(s60,s51,s42,R08,c08);
fa06: FA port map(s33,s24,s15,R09,c09);
fa07: FA port map(s70,s61,s52,R10,c10);
fa08: FA port map(s43,s34,s25,R11,c11);
ha02: HA port map(s16,s07,R12,c12);
fa09: FA port map(s71,s62,s53,R13,c13);
fa90: FA port map(s44,s35,s26,R14,c14);
fa31: FA port map(s72,s63,s54,R15,c15);
fa32: FA port map(s45,s36,s27,R16,c16);
fa33: FA port map(s73,s64,s55,R17,c17);
ha03: HA port map(s46,s37,R18,c18);
fa34: FA port map(s74,s65,s56,R19,c19);
fa35: FA port map(s75,s66,s57,R20,c20);
ha04: HA port map(s76,s67,R21,c21);

--Etapa 2
ha10: HA port map(R02,c01,R22,c22);
fa10: FA port map(s03,c02,R03,R23,c23);
fa11: FA port map(R04,R05,c03,R24,c24);
fa12: FA port map(R06,R07,c04,R25,c25);
fa13: FA port map(R08,R09,s06,R26,c26);
ha11: HA port map(c06,c07,R27,c27);
fa14: FA port map(R10,R11,R12,R28,c28);
ha12: HA port map(c08,c09,R29,c29);
fa15: FA port map(R13,R14,s17,R30,c30);
fa16: FA port map(c10,c11,c12,R31,c31);
fa17: FA port map(R15,R16,c13,R32,c32);
fa18: FA port map(R17,R18,c15,R33,c33);
fa19: FA port map(R19,c17,c18,R34,c34);
ha13: HA port map(R20,c19,R35,c35);
ha14: HA port map(R21,c20,R36,c36);

--Etapa 3
ha40: HA port map(R23,c22,R37,c37);
ha41: HA port map(c23,R24,R38,c38);
fa40: FA port map(c24,R25,c05,R39,c39);
fa41: FA port map(c25,R26,R27,R40,c40);
fa42: FA port map(c26,c27,R28,R41,c41);
fa43: FA port map(c28,c29,R30,R42,c42);
fa44: FA port map(c30,c31,R32,R43,c43);
fa45: FA port map(c32,c16,R33,R44,c44);
fa46: FA port map(c33,s47,R34,R45,c45);
ha42: HA port map(R35,c34,R46,c46);
ha43: HA port map(c35,R36,R47,c47);
fa47: FA port map(s77,c21,c36,R48,c48);

--Etapa 4
ha50: HA port map(c37,R38,R49,c49);
fa50: FA port map(R39,c38,c49,R50,c50);
fa51: FA port map(R40,c39,c50,R51,c51);
fa52: FA port map(c40,R41,R29,R52,c52);
fa53: FA port map(c41,R31,R42,R53,c53);
fa54: FA port map(c14,c42,R43,R54,c54);
fa55: FA port map(R44,c43,c54,R55,c55);
fa56: FA port map(c44,R45,c55,R56,c56);
fa57: FA port map(R46,c45,c56,R57,c57);
fa58: FA port map(c46,R47,c57,R58,c58);
fa59: FA port map(R48,c47,c58,R59,c59);

--Etapa 5
ha70: HA port map(c51,R52,R60,c60);
fa70: FA port map(c52,R53,c60,R61,c61);
fa71: FA port map(c53,R54,c61,R62,c62);
ha71: HA port map(R55,c62,R63,c63);
ha72: HA port map(R56,c63,R64,c64);
ha73: HA port map(R57,c64,R65,c65);
ha74: HA port map(R58,c65,R66,c66);
ha75: HA port map(R59,c66,R67,c67);
fa81: FA port map(c48,c59,c67,R68,c68);


X(0) <= s00;
X(1) <= R01;
X(2) <= R22;
X(3) <= R37;
X(4) <= R49;
X(5) <= R50;
X(6) <= R51;
X(7) <= R60;
X(8) <= R61;
X(9) <= R62;
X(10) <= R63;
X(11) <= R64;
X(12) <= R65;
X(13) <= R66;
X(14) <= R67;
X(15) <= R68 or c68;

		sA <= A ;
		sB <= B ;
--		sX <= X ;
end Behavioral;