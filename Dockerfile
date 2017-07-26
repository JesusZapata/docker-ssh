FROM ubuntu:14.04
MAINTAINER Jesus Zapata <jesus@vauxoo.com>

# Install OpenSSH
RUN apt-get update && apt-get upgrade -y && apt-get install -y openssh-server

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
