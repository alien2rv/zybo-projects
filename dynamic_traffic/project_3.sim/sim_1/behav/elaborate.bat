@echo off
set xv_path=F:\\xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 4c74a00e081f4117aa46451f31b48456 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot fx4_behav xil_defaultlib.fx4 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
