#!/bin/bash

if test -n "${RSA_PRIVATE_KEY}"; then
  echo -e $(echo $RSA_PRIVATE_KEY | sed -e 's/ /\\n/g' \
    -e 's/-----BEGIN\\nRSA\\nPRIVATE\\nKEY-----/-----BEGIN RSA PRIVATE KEY-----/' \
    -e 's/-----END\\nRSA\\nPRIVATE\\nKEY-----/-----END RSA PRIVATE KEY-----/') > /root/.ssh/id_rsa
  chmod 0600 /root/.ssh/id_rsa
  ssh-keygen -y -f /root/.ssh/id_rsa >> /home/r10k/.ssh/authorized_keys
fi
