# ZeroTier Configuration Automation

## Usage
Executing ZeroTier, Sunshine, Cloudflare WARP, and command/function using script

## Description

### Client-side

| Name | Usage | Note |
|----------|----------|----------|
| connectClient.ps1   | .\client\connectClient.ps1 -network_id "_network id_" | network_id as passing parameter  |
| disconnectClient.ps1    | .\client\disconnectClient.ps1 -network_id "_network id_"  | network_id as passing parameter   |
| pairSunshine.ps1   | .\client\pairSunhine.ps1 -session_id "_session_id_"   | session_id as passing parameter |
| runMoonlight.ps1  | .\client\runMoonlight.ps1   |    |

### VM-side

| Name | Usage | Note |
|----------|----------|----------|
| connectVM.ps1  |.\vm\connectVM.ps1 | Check the IP for API   |
| createNew.ps1   | .\vm\createNew.ps1  |    |
| deleteNet.ps1   | .\vm\deleteNet.ps1 -session_id "_session_id_"  | session_id as passing parameter |
| disconnectVM.ps1   | .\vm\disconnectVM.ps1  |    |
| editNet.ps1   | .\vm\editNet.ps1  | Check the IP for API   |
| runSunshine.ps1   | .\vm\runSunshine.ps1 -pin "_pin_"   | pin as passing parameter    |

### Warp

| Name | Usage | Note |
|----------|----------|----------|
| counterEduroam.ps1   | .\warp\counterEduroam.ps1 | to check wheter the network is available for ZeroTier  |
| warpConnect.ps1    | .\warp\warpConnect.ps1  |    |
| warpDisconnect.ps1   | .\warp\warpDisconnect.ps1 |  |

### Controller

| Name | Usage | Note |
|----------|----------|----------|
| clientEnd.ps1   |.\controller\clientEnd.ps1 -network_id "_network id_"  | network_id as passing parameter  |
| clientStart.ps1    | .\controller\clientStart.ps1 -network_id "_network id_" -session_id "_session_id_"   | network_id and session_id as passing parameter   |
| vmEnd.ps1   | .\controller\vmEnd.ps1 -session_id "_session_id_"   | session_id as passing parameter |
| vmStart.ps1  | .\controller\vmStart.ps1 -pin "_pin_"  | pin as passing parameter   |

## Main Flow of Process

### Using Controller
`clientStart.ps1`  → trigger on client if there is new session request
`clientEnd.ps1`    → trigger on client if there is end session request
`vmStart.ps1`      → trigger on VM if there is new session request
`vmEnd.ps1`        → trigger on VM if there is end session request

>[!NOTE]
> API is not deployed yet
> session_is is still a passing parameter
> recieving PIN is still a passing parameter
> recieving PIN automatically in VM is not yet implemented
