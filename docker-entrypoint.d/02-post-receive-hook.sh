#!/bin/bash
set -e

ln -sf /post-receive /srv/puppetmaster.git/hooks/
ln -sf /post-receive.d /srv/puppetmaster.git/hooks/
