@echo off
set xv_path=F:\\xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xsim fx4_behav -key {Behavioral:sim_1:Functional:fx4} -tclbatch fx4.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
