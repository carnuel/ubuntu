FROM ubuntu:15.10
MAINTAINER carnuel
USER root

# Install dev tools
RUN apt-get update &&  apt-get install -y \
		curl \
		nano \
		openssh-client \
		openssh-server \
		rsync \
		sudo \
		tar \
		vim

# Install Java
RUN mkdir -p /usr/java/default && \
	curl -Ls 'http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz' \
	-H 'Cookie: oraclelicense=accept-securebackup-cookie' | \
	tar --strip-components=1 -xz -C /usr/java/default/

# Set environment variables
ENV JAVA_HOME /usr/java/default/
ENV PATH $PATH:$JAVA_HOME/bin

# Passwordless SSH connection
RUN rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key /root/.ssh/id_rsa && \
        ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
        ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
        ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
        cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
