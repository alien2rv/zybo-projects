----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.09.2016 21:39:08
-- Design Name: 
-- Module Name: fx4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fx4 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC_VECTOR (3 downto 0);
           clk,clr : in std_logic;
           seca : out std_logic_vector (3 downto 0);
           secb : out std_logic_vector (3 downto 0);
           lights : out STD_LOGIC_VECTOR (5 downto 0)
           );
end fx4;



architecture Behavioral of fx4 is

component division is
    port(
        operanda:     in std_logic_vector(7 downto 0);    
        operandb:     in std_logic_vector(7 downto 0);
        errorsig:     out std_logic := '0';
        result_low:   out std_logic_vector(7 downto 0);
        result_high:  out std_logic_vector(7 downto 0)
    );
end component;

component traffic is
port (clk: in STD_LOGIC;
seca : in std_logic_vector(3 downto 0);
secb : in std_logic_vector(3 downto 0);
clr: in STD_LOGIC;
lights: out STD_LOGIC_VECTOR(5 downto 0));
end component;


constant b: STD_LOGIC_VECTOR(3 downto 0) := "1111";
signal m : std_logic_vector(7 downto 0);
signal siga,sigb : std_logic_vector(3 downto 0);
signal sum,result_high,result_low : std_logic_vector(7 downto 0);--
signal x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,errorsig : std_logic;
signal c10,c11,c12,c13,c20,c21,c22,c23,c30,c31,c32 : std_logic;
signal s11,s12,s13,s20,s21,s22,s23 : std_logic;
begin

-- multiolication algo
x1 <= a(1) and b(0);
x2 <= a(0) and b(1);
x3 <= a(2) and b(0);
x4 <= a(1) and b(1);
x5 <= a(3) and b(0);
x6 <= a(2) and b(1);
x7 <= a(3) and b(1);
x8  <= a(0) and b(2);
x9  <= a(1) and b(2);
x10 <= a(2) and b(2);
x11 <= a(3) and b(2);
x12 <= a(0) and b(3);
x13 <= a(1) and b(3);
x14 <= a(2) and b(3);
x15 <= a(3) and b(3);
--level 1
c10 <= x1 and x2;
c11 <= (x3 and x4) or (x3 and c10) or (x4 and c10);
c12 <= (x5 and x6) or (x5 and c11) or (x6 and c11);
c13 <= x7 and c12;
s11 <= x3 xor x4 xor c10;
s12 <= x6 xor x5 xor c11;
s13 <= x7 xor c12;
--level 2
c20 <= x8 and s11;
c21 <= (x9 and s12) or (x9 and c20) or (s12 and c20);
c22 <= (x10 and s13) or (x10 and c21) or (s13 and c21);
c23 <= (x11 and c22) or (x11 and c13) or (c22 and c13);
s21 <= x9 xor s12 xor c20;
s22 <= x10 xor s13 xor c21;
s23 <= x11 xor c22 xor c13;
--level 3
c30 <= s21 and x12;
c31 <= (x13 and s22) or (x13 and c30) or (s22 and c30);
c32 <= (x14 and s23) or (x14 and c31) or (s23 and c31);
-- final
m(0) <= a(0) and b(0) ;
m(1) <= x1 xor x2;
m(2) <= x8 xor s11;
m(3) <= x12 xor s21;
m(4) <= x13 xor s22 xor c30;
m(5) <= x14 xor s23 xor c31;
m(6) <= x15 xor c23 xor c32;
m(7) <= (x15 and c23) or (x15 and c32) or (c23 and c32);



--now we are summing
sum <= ("0000" & a) + ("0000" & cin);



-- now we are using division algo
hari : division port map(m,sum,errorsig,result_low,result_high);
siga(0) <= result_high(0);
siga(1) <= result_high(1);
siga(2) <= result_high(2);
siga(3) <= result_high(3);


-- now we sub seca from 10;

seca <= siga;
sigb <= b - siga;
secb <= sigb;
-- calling traffic;
vayu : traffic port map(clk,siga,sigb,clr,lights);


end Behavioral;
