#!/bin/bash

if test -n "${RSA_PRIVATE_KEY}"; then
  echo -e "${RSA_PRIVATE_KEY}" > /tmp/id_rsa
  chmod 0600 /tmp/id_rsa
  ssh-keygen -y -f /tmp/id_rsa >> /home/r10k/.ssh/authorized_keys
  rm -f /tmp/id_rsa
fi
