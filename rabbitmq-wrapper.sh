#!/usr/bin/env bash

sed -i "21s|.*|    {default_user, <<\"$USERNAME\">>},|" config/rabbitmq.config
sed -i "22s|.*|    {default_pass, <<\"$PASSWORD\">>},|" config/rabbitmq.config

# Enable management
rabbitmq-plugins enable rabbitmq_management --offline

# Start server
rabbitmq-server