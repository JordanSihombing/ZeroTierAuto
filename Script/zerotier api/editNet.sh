#!/bin/bash

TARGET="http://IP_FOR_API/getid"

# Send HTTP GET Request to retrieve the last ID
response=$(curl -s -X GET "${TARGET}")

# Extract the ID from the response
network_id=$(echo "$response" | jq -r '.id')

# API Token
API_TOKEN="x3WCnpQ9DYjVGaeElv8C3XpKYS8M4O4y"

# API Endpoint URL
API_URL="https://my.zerotier.com/api/network/${network_id}"

# New request body JSON
REQUEST_BODY='{
  "config": {
    "capabilities": [{}],
    "dns": {
      "domain": "google.com",
      "servers": ["10.0.0.3"]
    },
    "enableBroadcast": true,
    "ipAssignmentPools": [
      {
        "ipRangeStart": "10.0.0.1",
        "ipRangeEnd": "10.0.0.255"
      }
    ],
    "mtu": 2800,
    "multicastLimit": 32,
    "name": "My ZeroTier Network",
    "private": false,
    "routes": [
      {
        "target": "10.0.0.0/24",
        "via": null
      }
    ],
    "rules": [{}],
    "ssoConfig": {
      "enabled": true,
      "mode": "default",
      "clientId": "some-client-id",
      "allowList": ["string"]
    },
    "tags": [{}],
    "v4AssignMode": {"zt": true},
    "v6AssignMode": {"6plane": true, "rfc4193": false, "zt": false}
  },
  "description": "Some descriptive text about my network.",
  "rulesSource": "accept;",
  "permissions": {
    "00000000-0000-0000-0000-000000000000": {"a": true, "d": true, "m": true, "r": true}
  },
  "ownerId": "00000000-0000-0000-0000-000000000000",
  "capabilitiesByName": {},
  "tagsByName": {}
}'

# Send HTTP PATCH Request to update the network
response=$(curl -X PATCH \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -d "${REQUEST_BODY}" \
  "${API_URL}")

echo "Network updated successfully."
