@echo off

:: Run the scripts one by one
call Script/zerotier api/createNew.sh
call Script/zerotier api/editNet.sh
start Script/zerotier cli/startCall.bat
call Script/zerotier api/sendPIN.sh

exit /B
