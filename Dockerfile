FROM debian:stable-slim
ARG FUNC_NAME=rss-gram

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install curl jq \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER root
ADD https://github.com/openfaas/faas/releases/download/0.8.0/fwatchdog /usr/bin
RUN chmod +x /usr/bin/fwatchdog

COPY func.sh /usr/bin/${FUNC_NAME}
ENV fprocess="/usr/bin/${FUNC_NAME}"
ENV write_debug="true"

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1
ENTRYPOINT [ "fwatchdog" ]
