@echo off
echo -----------------------------------
ipconfig | findstr "IPv4 Address" | findstr "192.168.0"

echo Junkis i kazkuri is situ visuje pateiktu ip.
pause