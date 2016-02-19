#!/bin/bash

TMPFILE=$(mktemp --suffix=.json)

cat << EOF > $TMPFILE
{
  "ref": "${refname}"
}
EOF

SIG=$(echo "${WEBHOOK_SECRET}" | sha1sum | awk '{print "X-Hub-Signature: sha1="$1}')

curl -H "Content-Type: application/json" -H "${SIG}" --data "@${TMPFILE}" http://webhook:9000/hooks/r10k

rm -f "${TMPFILE}"
