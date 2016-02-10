#!/bin/bash

if test -n "${RSA_PRIVATE_KEY}"; then
  echo -e $(echo $RSA_PRIVATE_KEY | sed -e 's/ /\\n/g' \
    -e 's/-----BEGIN\\nRSA\\nPRIVATE\\nKEY-----/-----BEGIN RSA PRIVATE KEY-----/' \
    -e 's/-----END\\nRSA\\nPRIVATE\\nKEY-----/-----END RSA PRIVATE KEY-----/') > ~r10k/.ssh/id_rsa
  chmod 0600 ~r10k/.ssh/id_rsa
  ssh-keygen -y -f ~r10k/.ssh/id_rsa >> ~r10k/.ssh/authorized_keys
fi
