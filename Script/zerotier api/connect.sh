#!/bin/bash

source createNew.sh #get Network ID from script to create new network

# API Token
API_TOKEN="x3WCnpQ9DYjVGaeElv8C3XpKYS8M4O4y"

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
