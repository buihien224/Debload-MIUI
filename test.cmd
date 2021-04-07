@echo off
adb devices -1 
set devices = adb devices -l 
echo %devices%
pause