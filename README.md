# RabbitMQ Docker image

[![Build Status](http://ci.hesjevik.im/buildStatus/icon?job=docker-rabbitmq)](http://ci.hesjevik.im/job/docker-rabbitmq/) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg?style=plastic)](https://registry.hub.docker.com/u/gainmaster/rabbitmq/)

This repository contains a **Dockerfile** for a base RabbitMQ Server image. This repository is a part of an automated build, published to the [Docker Hub][docker_hub_repository].

**Base image:** [gainmaster/docker-arch][docker_hub_base_image]

[docker_hub_repository]: https://registry.hub.docker.com/u/gainmaster/rabbitmq/
[docker_hub_base_image]: https://registry.hub.docker.com/u/gainmaster/archlinux/

### Installed packages

* [RabbitMQ][rabbitmq] - Highly reliable and performant enterprise messaging implementation of AMQP written in Erlang/OTP

[rabbitmq]: https://www.rabbitmq.com

## Resources

These resources have been helpful when creating this Docker image:

* https://www.rabbitmq.com/clustering.html
