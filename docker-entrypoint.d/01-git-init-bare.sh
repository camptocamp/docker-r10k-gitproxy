#!/bin/bash
set -e

cd /srv/puppetmaster.git/ && git rev-parse --is-bare-repository > /dev/null \
  || su - r10k -s /bin/bash -c "cd /srv/puppetmaster.git && git --bare init"
