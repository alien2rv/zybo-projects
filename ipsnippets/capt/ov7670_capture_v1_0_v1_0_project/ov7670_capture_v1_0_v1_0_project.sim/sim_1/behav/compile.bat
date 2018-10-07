@echo off
set xv_path=F:\\xilinx\\Vivado\\2014.4\\bin
echo "xvhdl -m64 -prj ov7670_capture_vhdl.prj"
call %xv_path%/xvhdl  -m64 -prj ov7670_capture_vhdl.prj -log compile.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
