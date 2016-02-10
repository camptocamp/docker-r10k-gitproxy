#!/bin/bash

if test -n "${RSA_PRIVATE_KEY}"; then
  echo -e $RSA_PRIVATE_KEY > ~r10k/.ssh/id_rsa
  chmod 0600 ~r10k/.ssh/id_rsa
  ssh-keygen -y -f ~r10k/.ssh/id_rsa > ~r10k/.ssh/id_rsa.pub
fi
