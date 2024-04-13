@echo off
:: BatchGotAdmin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------

echo Initiating ZeroTier connection...

:: Check for ZeroTier Desktop UI executable
set "ZerotierExe="
for %%i in ("%ProgramFiles%\ZeroTier\One\zerotier_desktop_ui.exe" "%ProgramFiles(x86)%\ZeroTier\One\zerotier_desktop_ui.exe") do (
    if exist "%%~i" (
        set "ZerotierExe=%%~i"
        goto :StartZerotier
    )
)

echo ZeroTier Desktop UI not found.
goto :EndScript

::Initiating ZeroTier and connect to the network 
:StartZerotier
start "" "%ZerotierExe%"
timeout /t 5 /nobreak
zerotier-cli join 41d49af6c2cdaccf  REM --> change the network ID to corresponding network ID
timeout /t 3 /nobreak
zerotier-cli status
echo ZeroTier connection established!
taskkill /f /im zerotier_desktop_ui.exe
timeout /t 3 /nobreak

:EndScript
exit /B
