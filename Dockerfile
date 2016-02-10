FROM debian:jessie

MAINTAINER mickael.canevet@camptocamp.com

# Install and configure openssh-server
RUN apt-get update \
  && apt-get install -y openssh-server clusterssh git ruby \
  && rm -f /etc/ssh/ssh_host_*_key* \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/run/sshd /etc/ssh/ssh_host_keys \
  && sed -i -e 's@/etc/ssh/ssh_host@/etc/ssh/ssh_host_keys/ssh_host@g' /etc/ssh/sshd_config

# Configure git user
RUN useradd -r -s /usr/bin/git-shell r10k \
  && mkdir -p ~r10k/.ssh

# Configure git repository
RUN mkdir /srv/puppetmaster.git \
  && chown r10k.r10k /srv/puppetmaster.git

# Configure git hook
COPY post-receive /post-receive
COPY post-receive.d /post-receive.d/

# Define VOLUMES
VOLUME ["/srv/puppetmaster.git", "/etc/ssh/ssh_host_keys"]

# Install hooks dependencies
RUN gem install rack github_api --no-ri --no-rdoc

# Configure entrypoint and command
COPY /docker-entrypoint.sh /
COPY /docker-entrypoint.d/* /docker-entrypoint.d/
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
