@echo off

set "MoonlightExe="
for %%i in ("%ProgramFiles%\Moonlight Game Streaming\Moonlight.exe" "%ProgramFiles(x86)%\Moonlight Game Streaming\Moonlight.exe") do (
    if exist "%%~i" (
        set "MoonlightExe=%%~i"
        goto :StartMoonlight
    )
)

echo Moonlight is not installed.
goto :EOF

:StartMoonlight
echo Moonlight is installed.
start "" "%MoonlightExe%"
goto :EOF
