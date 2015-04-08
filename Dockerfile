FROM bachelorthesis/archlinux
MAINTAINER Knut Lorvik <knutlor@tihlde.org>

ADD rabbitmq-fs.tar.xz /

# Define default command
ENTRYPOINT ["rabbitmq-server"]

# Expose ports
EXPOSE 5672
EXPOSE 15672