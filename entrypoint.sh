#!/usr/bin/env bash
set -e

if ! grep ${SSH_USER} /etc/passwd ; then
	# Create the user with ssh access
	useradd -d "/home/${SSH_USER}" -m -s "/bin/bash" "${SSH_USER}"
	mkdir -p /home/${SSH_USER}/.ssh/

	# Configure ssh_config
	mkdir -p /var/run/sshd
	echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
	echo "PermitRootLogin no" >> /etc/ssh/sshd_config
	echo "AllowUsers ${SSH_USER}" >> /etc/ssh/sshd_config

	# Copy the authorized_keys
	touch /home/${SSH_USER}/.ssh/authorized_keys
	echo "$SSH_KEY" >> /home/${SSH_USER}/.ssh/authorized_keys
fi

exec "$@"
