@echo off
SETLOCAL EnableDelayedExpansion

REM Set the port number to check
SET "PORT=<port_number>"

REM Find the PID associated with the port
FOR /F "tokens=5" %%P IN ('netstat -aon ^| findstr ":%PORT%" ^| find "LISTENING"') DO (
    SET "PID=%%P"
)

REM Kill the process using the PID
IF DEFINED PID (
    taskkill /F /PID !PID!
    echo Process with PID !PID! terminated.
) ELSE (
    echo No process found using port %PORT%.
)

ENDLOCAL