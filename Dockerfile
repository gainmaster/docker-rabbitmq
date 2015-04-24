FROM gainmaster/archlinux:base
MAINTAINER Knut Lorvik <knutlor@tihlde.org>

COPY rabbitmq.pkg.tar.xz  /tmp/rabbitmq.pkg.tar.xz
COPY rabbitmq-wrapper.sh  /usr/local/bin/rabbitmq-wrapper
COPY rabbitmq.config      /etc/rabbitmq/rabbitmq.config

ENV RABBITMQ_USERNAME gainmaster
ENV RABBITMQ_PASSWORD gainmaster

RUN pacman-install-tar /tmp/rabbitmq.pkg.tar.xz

EXPOSE 5672
EXPOSE 15672

ENTRYPOINT ["rabbitmq-wrapper"]