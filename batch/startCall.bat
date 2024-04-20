@echo off
echo Running Zerotier...
call runZeroTier.bat
echo Running Zerotier completed.

echo Running Moonlight...
call runMoonlight.bat
echo Running Moonlight completed.

powershell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('All scripts executed.', 'Notification', 'OK', 'Information')"


echo connection established!
exit /B
