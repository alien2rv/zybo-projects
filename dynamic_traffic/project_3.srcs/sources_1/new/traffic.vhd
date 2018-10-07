
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
entity traffic is
port (clk: in STD_LOGIC;
seca : in std_logic_vector(3 downto 0);
secb : in std_logic_vector(3 downto 0);
clr: in STD_LOGIC;
lights: out STD_LOGIC_VECTOR(5 downto 0));
end traffic;
architecture traffic of traffic is
type state_type is (s0, s1, s2, s3, s4, s5);
signal state: state_type;
signal count: STD_LOGIC_VECTOR(3 downto 0);
signal siga,sigb: STD_LOGIC_VECTOR(3 downto 0);
constant SEC1: STD_LOGIC_VECTOR(3 downto 0) := "0011";
begin
siga <= seca;
sigb <= secb;
process(clk, clr)
begin
if clr = '1' then
state <= s0;
count <= X"0";
elsif clk'event and clk = '1' then
case state is
when s0 =>
if count < siga then
state <= s0;
count <= count + 1;
else
state <= s1;
count <= X"0";
end if;
when s1 =>
if count < SEC1 then
state <= s1;
count <= count + 1;
else
state <= s2;
count <= X"0";
end if;
when s2 =>
if count < SEC1 then
state <= s3;
count <= count + 1;
else
state <= s3;
count <= X"0";
end if;
when s3 =>
if count < sigb then
state <= s3;
count <= count + 1;
else
state <= s4;
count <= X"0";
end if;
when s4 =>
if count < SEC1 then
state <= s4;
count <= count + 1;
else
state <= s5;
count <= X"0";
end if;
when s5 =>
if count < SEC1 then
state <= s5;
count <= count + 1;
else
state <= s0;
count <= X"0";
end if;
when others =>
state <= s0;
end case;
end if;
end process;
C2: process(state)
begin
case state is
when s0 => lights <= "100001";
when s1 => lights <= "100010";
when s2 => lights <= "100100";
when s3 => lights <= "001100";
when s4 => lights <= "010100";
when s5 => lights <= "100100";
when others => lights <= "100001";
end case;
end process;
end traffic;