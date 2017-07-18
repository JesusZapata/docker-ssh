#!/usr/bin/env bash
set -e

# Create the user with ssh access
useradd -d "/home/${SSH_USER}" -m -s "/bin/bash" "${SSH_USER}"
mkdir -p /home/${SSH_USER}/.ssh/

# Configure ssh_config
mkdir -p /var/run/sshd
if ! grep "PasswordAuthentication no" /etc/ssh/ssh_config ; then
	echo "Port 22" >> /etc/ssh/ssh_config
	echo "PasswordAuthentication no" >> /etc/ssh/ssh_config
	echo "AuthenticationMethods 'publickey'" >> /etc/ssh/ssh_config
	echo "PermitRootLogin no" >> /etc/ssh/ssh_config
	echo "AllowUsers ${SSH_USER}" >> /etc/ssh/ssh_config
fi

# Copy the authorized_keys
touch /home/${SSH_USER}/.ssh/authorized_keys
echo "$SSH_KEY" >> /home/${SSH_USER}/.ssh/authorized_keys

exec "$@"
