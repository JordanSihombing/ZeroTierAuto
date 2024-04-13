# ZeroTier Configuration Automation

## Usage
Executing ZeroTier command/function using script

## Description

### Zerotier API script

| Name | Usage | Note |
|----------|----------|----------|
| createNew.sh   | Create a new network and POST the network ID to API | Check the IP for API and API token  |
| connect.sh   | GET the existing network ID and connect to the network   | Check the IP for API and API token   |
| editNet.sh   | GET the existing network ID and set the network to "Public"   | Check the IP for API and API token   |
| deleteNet.sh   | GET the existing network ID and delete the network  | Check the IP for API and API token   |
| sendPIN.sh   | Initiate a textbox to recieve PIN from user and send the PIN to Sunshine   |    |
| textbox.py   | Create a new textbox used in sendPIN.sh   |    |


### Zerotier CLI script

| Name | Usage | Note |
|----------|----------|----------|
| runZeroTier.bat  | - Get administrator permission to run ZeroTier CLI <br> - Find zerotier_desktop_ui.exe in the machine <br>- GET the existing network ID and connect to the network    | Check the IP for API   |
| runMoonlight.bat   | Find Moonlight.exe in the machine and start Moonlight  |    |
| forgetZerotier.bat   | - Get administrator permission to run ZeroTier CLI <br> - Find zerotier_desktop_ui.exe in the machine <br>- GET the existing network ID and delete/leave the network   | Check the IP for API   |
| startCall.bat   | Execute runZeroTier.bat and runMoonlight.bat   |    |



## Main Flow of Process

### Establish Connection
`createNew.sh` → `editNet.sh` → `startCall.bat` or `connect.sh` → `sendPIN.sh`
> Preferably using `startCall.bat` because ZeroTier API to connect is underdeveloped


### Terminate Connection
`deleteNet.sh` or `forgetZerotier.bat`
> Preferably using `deleteNet.sh` because it doesn't require the user to start zerotier_desktop_ui.exe
