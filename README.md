# RabbitMQ Docker image

[![Build Status](http://jenkins.hesjevik.im/buildStatus/icon?job=docker-rabbitmq)](http://jenkins.hesjevik.im/job/docker-rabbitmq/) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg?style=plastic)](https://registry.hub.docker.com/u/bachelorthesis/rabbitmq/)

This repository contains a **Dockerfile** for a base RabbitMQ Server image. It provides **Vagrantfiles** for development. This repository is a part of an automated build, published to the [Docker Hub][docker_hub_repository].

**Base image:** [bachelorthesis/docker-arch][docker_hub_base_image]

[docker_hub_repository]: https://registry.hub.docker.com/u/bachelorthesis/rabbitmq/
[docker_hub_base_image]: https://registry.hub.docker.com/u/bachelorthesis/archlinux/

### Installed packages

* [RabbitMQ][rabbitmq] - Highly reliable and performant enterprise messaging implementation of AMQP written in Erlang/OTP

[rabbitmq]: https://www.rabbitmq.com

## Resources

These resources have been helpful when creating this Docker image:
