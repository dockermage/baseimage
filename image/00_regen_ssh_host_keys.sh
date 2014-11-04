#!/bin/bash
set -e
source /etc/container_environment.sh

if [ $DOCKER_DISABLE_SSH ]; then
	echo "Found DOCKER_DISABLE_SSH, removing sshd"
	rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
	exit 0
fi

if [[ ! -e /etc/ssh/ssh_host_rsa_key ]]; then
	echo "No SSH host key available. Generating one..."
	export LC_ALL=C
	export DEBIAN_FRONTEND=noninteractive
	dpkg-reconfigure openssh-server
fi
