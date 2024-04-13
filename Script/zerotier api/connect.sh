#!/bin/bash

source createNew.sh #get Network ID from script to create new network

# API Token
API_TOKEN="pHeu4iyxaLTivxSm8oB7hI1hSaPK7zX2"

# API Endpoint URL
API_URL="https://my.zerotier.com/api/network/${network_id}/member"

# Request Body JSON
REQUEST_BODY='{
  "allowDNS": true,
  "allowDefault": true,
  "allowManaged": true,
  "allowGlobal": true
}'

# Send HTTP POST Request
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -d "${REQUEST_BODY}" \
  "${API_URL}"
