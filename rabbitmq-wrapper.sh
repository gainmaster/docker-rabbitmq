#!/usr/bin/env bash

function clusterize {
    sleep 10
    rabbitmqctl stop_app
    rabbitmqctl join_cluster rabbit@$CLUSTER_WITH
    rabbitmqctl start_app
}

sed -i "21s|.*|    {default_user, <<\"$RABBITMQ_USERNAME\">>},|" /etc/rabbitmq/rabbitmq.config
sed -i "22s|.*|    {default_pass, <<\"$RABBITMQ_PASSWORD\">>},|" /etc/rabbitmq/rabbitmq.config

# Enable management
rabbitmq-plugins enable rabbitmq_management --offline

# Start server
ping -c 1 $CLUSTER_WITH
if [ $? -eq 2 ]; then
    rabbitmq-server
else
    clusterize &
    rabbitmq-server
fi
