@echo off
echo -----------------------------------
ipconfig | findstr "IPv4 Address" | findstr "192.168."

echo Junkis i kazkuri is situ visuje pateiktu ip.
pause