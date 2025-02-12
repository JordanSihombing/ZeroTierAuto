# ZeroTier Configuration Automation

## Dependency

This script controls ZeroTier, Moonlight, Sunshine, and Cloudflare WARP for game streaming purposes. The client acts as the user, and the VM serves as the host.

### Client-side

- [ZeroTier](https://www.zerotier.com/download/)
- [Moonlight](https://github.com/moonlight-stream/moonlight-qt/releases)
- [Cloudflare WARP](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/download-warp/)

### VM-side

- [ZeroTier](https://www.zerotier.com/download/)
- [Sunshine](https://github.com/LizardByte/Sunshine/releases/tag/v0.18.4)
- [Cloudflare WARP](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/download-warp/)


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
| stopApp.ps1   | .\vm\stopApp.ps1   |   |
| sunshineRegister.ps1   | .\vm\sunshineRegister.ps1   |   |


### Controller

| Name | Usage | Note |
|----------|----------|----------|
| clientEnd.ps1   |.\controller\clientEnd.ps1 -network_id "_network id_"  | network_id as passing parameter  |
| clientStart.ps1    | .\controller\clientStart.ps1 -network_id "_network id_" -session_id "_session_id_"   | network_id and session_id as passing parameter   |
| vmEnd.ps1   | .\controller\vmEnd.ps1  |  |
| vmStart.ps1  | .\controller\vmStart.ps1  |    |

### Warp

| Name | Usage | Note |
|----------|----------|----------|
| warpConnect.ps1    | .\controller\warp\warpConnect.ps1  |    |
| warpDisconnect.ps1   | .\controller\warp\warpDisconnect.ps1 |  |


## Using Controller
`clientStart.ps1`  → trigger on client if there is new session request <br />
`clientEnd.ps1`    → trigger on client if there is end session request <br />
`vmStart.ps1`      → trigger on VM if there is new session request <br />
`vmEnd.ps1`        → trigger on VM if there is end session request <br />
