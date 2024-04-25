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
| connectVM.ps1  |.\vm\connectVM.ps1 |    |
| createNew.ps1   | .\vm\createNew.ps1  |    |
| deleteNet.ps1   | .\vm\deleteNet.ps1  |  |
| disconnectVM.ps1   | .\vm\disconnectVM.ps1  |    |
| editNet.ps1   | .\vm\editNet.ps1  |  |
| runSunshine.ps1   | .\vm\runSunshine.ps1    |    |
| runApp.ps1   | .\vm\runApp.ps1  |  |
| stopApp.ps1   | .\vm\runApp.ps1   |   |

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
| vmEnd.ps1   | .\controller\vmEnd.ps1  |  |
| vmStart.ps1  | .\controller\vmStart.ps1  |    |

## Main Flow of Process

### Using Controller
`clientStart.ps1`  → trigger on client if there is new session request <br />
`clientEnd.ps1`    → trigger on client if there is end session request <br />
`vmStart.ps1`      → trigger on VM if there is new session request <br />
`vmEnd.ps1`        → trigger on VM if there is end session request <br />

>[!NOTE]
> session_id and network_id is a passing parameter on client <br />
