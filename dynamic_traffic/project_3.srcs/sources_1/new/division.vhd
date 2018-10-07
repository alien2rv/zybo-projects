library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity division is
    port(
        operanda:     in std_logic_vector(7 downto 0);
       
        operandb:     in std_logic_vector(7 downto 0);
        errorsig:     out std_logic := '0';
        result_low:   out std_logic_vector(7 downto 0);
        result_high:  out std_logic_vector(7 downto 0)
    );
end division;



architecture foo of division is

begin

UNLABELED:
    process(operanda,operandb)
        variable quotient:  unsigned (7 downto 0);
        variable remainder: unsigned (7 downto 0);
    begin  
    -- if D == 0 then error(DivisionByZeroException) end
    -- Q := 0                 -- initialize quotient and remainder to zero
    -- R := 0
    -- for i = n-1...0 do     -- where n is number of bits in N
    --   R := R << 1          -- left-shift R by 1 bit
    --   R(0) := N(i)         -- set the least-significant bit of R equal to bit i of the numerator
    --   if R >= D then
    --     R := R - D
    --     Q(i) := 1
    --   end
    -- end

    -- We
        errorsig <= '0';      -- allows successive operations
        if operandb = "00000000" then
        --     i<= 0;
            assert  operandb /= "00000000"
                report "Division by Zero Exception"
                severity ERROR;
            errorsig <= '1';
        else 
            quotient := (others => '0'); -- "0000"
            remainder := (others => '0');
           for i in 7 downto 0 loop  
               remainder := remainder (6 downto 0) & '0';   -- r << 1
               remainder(0) := operanda(i);       -- operanda is numerator
               if remainder >= unsigned(operandb) then  -- operandb denominator
                    remainder := remainder - unsigned(operandb);
                    quotient(i) := '1';
               end if;
            end loop;
            result_high <= std_logic_vector(quotient); -- for error keeps
            result_low  <= std_logic_vector(remainder); -- last value (invalid)
        end if;
    end process;

end architecture foo;
