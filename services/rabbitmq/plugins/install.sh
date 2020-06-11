#!/bin/sh

echo
echo "============================================"
echo "Install RabbitMQ plugin script : install.sh"
echo "RabbitMQ version          : ${RABBITMQ_VERSION}"
echo "Extra Extensions          : ${RABBITMQ_PLUGINS}"
echo "Work directory            : ${PWD}"
echo "============================================"
echo

export PLUGINS=",${RABBITMQ_PLUGINS},"

if [ -z "${PLUGINS##*,rabbitmq_delayed_message_exchange,*}" ]; then
    echo "-------- Install rabbitmq_delayed_message_exchange --------"
    rabbitmq-plugins enable rabbitmq_delayed_message_exchange
fi
