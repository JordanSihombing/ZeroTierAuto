#!/bin/bash

TARGET="http://IP_FOR_API/getid"

# Send HTTP GET Request to retrieve the last ID
response=$(curl -s -X GET "${TARGET}")

# Extract the ID from the response
network_id=$(echo "$response" | jq -r '.id')

# Network ID and API Token
API_TOKEN="pHeu4iyxaLTivxSm8oB7hI1hSaPK7zX2"

# API Endpoint URL
API_URL="https://my.zerotier.com/api/network/${network_id}"

# Send HTTP DELETE Request
curl -X DELETE \
  -H "Authorization: Bearer ${API_TOKEN}" \
  "${API_URL}"
