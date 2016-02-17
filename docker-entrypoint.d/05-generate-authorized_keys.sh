#!/bin/bash

if getent hosts rancher-metadata > /dev/null ; then
  curl http://rancher-metadata/latest/self/stack/services/r10k/containers | while read container; do
    uuid=$(curl http://rancher-metadata/latest/self/stack/services/r10k/containers/$(echo container|cut -f1 -d'=')/uuid)
    curl --cert /etc/puppetlabs/puppet/ssl/certs/$(hostname -f).pem \
      --key /etc/puppetlabs/puppet/ssl/private_keys/$(hostname -f).pem \
      --cacert /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem \
      https://puppetca:8140/puppet-ca/v1/certificate/$uuid?environment=production > /tmp/$uuid.pem
    openssl x509 -pubkey -noout -in $uuid.pem  >> /home/r10k/.ssh/authorized_keys
  done
fi
