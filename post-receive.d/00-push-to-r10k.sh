#!/bin/bash

while read oldrev newrev refname; do
  tmpfile=$(mktemp --suffix=.json)
  
  cat << EOF > $tmpfile
  {
    "ref": "${refname}"
  }
EOF
  
  sig=$(cat "${tmpfile}" | openssl dgst -sha1 -hmac "${WEBHOOK_SECRET}" | awk '{print "X-Hub-Signature: sha1="$2}')
  
  curl -H "Content-Type: application/json" -H "${sig}" --data "@${tmpfile}" http://webhook:9000/hooks/r10k
  
  rm -f "${tmpfile}"
done
