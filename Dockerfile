FROM bachelorthesis/archlinux
MAINTAINER Knut Lorvik <knutlor@tihlde.org>

ENV RABBITMQ_VERSION 3.5.1

RUN pacman-install erlang-nox && \
  curl -SL https://www.rabbitmq.com/releases/rabbitmq-server/v$RABBITMQ_VERSION/rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.gz | tar xz

WORKDIR rabbitmq_server-$RABBITMQ_VERSION

# Define default command
ENTRYPOINT ["sbin/rabbitmq-server"]

# Expose ports
EXPOSE 5672
EXPOSE 15672