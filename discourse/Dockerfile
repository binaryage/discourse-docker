# -*- sh -*-

# Base image for all Discourse related processes.

FROM ubuntu:12.04
MAINTAINER srid

ENV DISCOURSE_VERSION master
ENV DISCOURSE_REPO https://github.com/binaryage/discourse.git
ENV RAILS_ENV production

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

ADD install /

RUN bash -xe /install

ADD	enter /
RUN	chmod +x /enter
WORKDIR   /discourse
ENTRYPOINT ["/enter"]
