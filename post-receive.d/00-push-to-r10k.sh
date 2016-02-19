#!/bin/bash

TMPFILE=$(mktemp --suffix=.json)

cat << EOF > $TMPFILE
{
  "ref": "${refname}"
}
EOF

SIG=$((sha1sum  | awk '{print "X-Hub-Signature: sha1="$1}')<<<"${WEBHOOK_SECRET}")

curl -H "Content-Type: application/json" -H "${SIG}" --data "@${TMPFILE}" http://webhook:9000/hooks/r10k

rm -f "${TMPFILE}"
