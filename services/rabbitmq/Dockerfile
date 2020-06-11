ARG RABBITMQ_VERSION
FROM rabbitmq:${RABBITMQ_VERSION}

ARG RABBITMQ_PLUGINS
COPY ./plugins /opt/rabbitmq/plugins
WORKDIR /opt/rabbitmq/plugins

RUN chmod +x install.sh && sh install.sh
