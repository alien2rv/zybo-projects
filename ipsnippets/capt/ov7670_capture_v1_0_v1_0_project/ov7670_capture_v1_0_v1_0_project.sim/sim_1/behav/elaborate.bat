@echo off
set xv_path=F:\\xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto c3f3942cb40548fa803873451f168c70 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot ov7670_capture_behav xil_defaultlib.ov7670_capture -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
