#!/bin/bash

while read oldrev newrev refname; do
  tmpfile=$(mktemp --suffix=.json)

  data="{\"ref\": \"${refname}\"}"
  
  sig=$(echo -n "${data}" | openssl dgst -sha1 -hmac "${WEBHOOK_SECRET}" | awk '{print "X-Hub-Signature: sha1="$2}')
  
  curl -X POST -H "Content-Type: application/json" -H "${sig}" --data "${data}" http://webhook:9000/hooks/r10k
  
  rm -f "${tmpfile}"
done
