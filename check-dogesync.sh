#!/bin/sh
MIN_PEERS=10
RPC_USER=MYUSER
RPC_PW=MYPW
SYNC=$(curl -s -m2 -N -X POST --data '{"jsonrpc":"1.0","id":"1","method":"getblockchaininfo","params":[]}' -H 'content-type:text/plain;' "https://${RPC_USER}:${RPC_PW}@${HAPROXY_SERVER_NAME}")
echo "${SYNC}" | grep -q "result"
if [ $? -ne 0 ]; then
  return 1
fi
SYNC=$(echo "${SYNC}" | jq .result.verificationprogress)
PEERS=$(curl -s -m2 -N -X POST --data '{"jsonrpc":"1.0","id":"1","method":"getpeerinfo","params":[]}' -H 'content-type:text/plain;' "https://${RPC_USER}:${RPC_PW}@${HAPROXY_SERVER_NAME}")
echo "${PEERS}" | grep -q "result"
if [ $? -ne 0 ]; then
  return 1
fi
PEERS=$(echo "${PEERS}" | jq -r '.result | length')
if [ $(echo "${SYNC} >= 0.999" | bc -l) = "1" -a "${PEERS}" -ge "${MIN_PEERS}" ]; then
  return 0
else
  return 1
fi

