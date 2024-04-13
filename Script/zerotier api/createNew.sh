#!/bin/bash

# API Token
API_TOKEN="pHeu4iyxaLTivxSm8oB7hI1hSaPK7zX2"

# API Endpoint URL
API_URL="https://api.zerotier.com/api/v1/network"

# Request Body JSON
REQUEST_BODY='{}'

# Send HTTP POST Request to create a new network
response=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -d "${REQUEST_BODY}" \
  "${API_URL}")

# Extract the ID from the response
network_id=$(echo "$response" | jq -r '.id')

#----------------------------------------------------------------------
TARGET="http://IP_FOR_API/sendid"

# Construct ID_BODY with network_id
BODY="{ \"id\": \"$network_id\" }"

send_id_response=$(curl -s -X POST \
      -H "Content-Type: application/json" \
      -d "${BODY}" \
      "$TARGET")

