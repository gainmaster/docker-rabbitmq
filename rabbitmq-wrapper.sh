#!/usr/bin/env bash

sed -i "21s|.*|    {default_user, <<\"$RABBITMQ_USERNAME\">>},|" /etc/rabbitmq/rabbitmq.config
sed -i "22s|.*|    {default_pass, <<\"$RABBITMQ_PASSWORD\">>},|" /etc/rabbitmq/rabbitmq.config

# Enable management
rabbitmq-plugins enable rabbitmq_management --offline

# Start server
runuser -l rabbitmq -c "rabbitmq-server"
