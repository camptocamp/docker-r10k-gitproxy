#!/bin/bash

TMPFILE=$(mktemp --suffix=.json)

cat << EOF > $TMPFILE
{
  "ref": "${refname}"
}
EOF

SIG=$(cat "${TMPFILE}" | openssl dgst -sha1 -hmac "${WEBHOOK_SECRET}" | awk '{print "X-Hub-Signature: sha1="$2}')

curl -H "Content-Type: application/json" -H "${SIG}" --data "@${TMPFILE}" http://webhook:9000/hooks/r10k

rm -f "${TMPFILE}"
