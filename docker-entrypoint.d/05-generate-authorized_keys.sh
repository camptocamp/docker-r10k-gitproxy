#!/bin/bash

echo $RSA_PRIVATE_KEY > /tmp/id_rsa
ssh-keygen -y -f /tmp/id_rsa >> /home/r10k/.ssh/authorized_keys
