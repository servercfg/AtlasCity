@echo off
@title RP Server #1
:iniServer
echo.
echo Server
echo.
echo.
echo Initiating Server 1 [Port:30120]
echo %date%
echo.
echo %time% : Starter serveren
FXServer +set citizen_dir %~dp0\citizen\ +exec server.cfg
echo %time% : Server was shut down..
timeout /t 2 >nul
echo %time% : Prøver at genstarte serveren...
timeout /t 3 >nul
echo.
goto iniServer