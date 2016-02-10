#!/bin/bash

if test -n "${RSA_PRIVATE_KEY}"; then
  echo $RSA_PRIVATE_KEY > ~r10k/.ssh/id_rsa
  ssh-keygen -y -f ~r10k/.ssh/id_rsa > ~r10k/.ssh/id_rsa.pub
fi
