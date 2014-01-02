# -*- sh -*-

# forked from https://gist.github.com/jpetazzo/5494158

FROM	ubuntu:12.04
MAINTAINER	srid

EXPOSE 5432
CMD /start postgres

# prevent apt from starting postgres right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

# https://bugs.launchpad.net/ubuntu/+source/lxc/+bug/813398
RUN apt-get -qy install language-pack-en 

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales


RUN	DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-9.1 postgresql-contrib-9.1

# install WAL-E
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y lzop pv build-essential python-dev wget
RUN wget --no-check-certificate https://bitbucket.org/pypa/setuptools/raw/0.8/ez_setup.py -O - | python
RUN easy_install pip
RUN pip install wal-e

# allow autostart again
RUN	rm /usr/sbin/policy-rc.d

ADD	start /
ADD     postgresql.conf /etc/postgresql/9.1/main/
RUN	chmod +x /start
