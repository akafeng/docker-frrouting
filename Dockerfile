FROM debian:bookworm-slim

RUN set -eux \
    && apt-get update -qyy \
    && apt-get install -qyy --no-install-recommends --no-install-suggests \
        ca-certificates \
        apt-transport-https \
        curl \
        lsb-release \
    && rm -rf /var/lib/apt/lists/* /var/log/*
RUN set -eux \
    && curl -s https://deb.frrouting.org/frr/keys.gpg | tee /usr/share/keyrings/frrouting.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/frrouting.gpg] https://deb.frrouting.org/frr/ $(lsb_release -s -c) frr-stable" | tee -a /etc/apt/sources.list.d/frr.list \
    && apt-get update -qyy \
    && apt-get install -qyy --no-install-recommends --no-install-suggests \
        tini \
        frr \
        frr-pythontools \
        iputils-ping \
        traceroute \
    && rm -rf /var/lib/apt/lists/* /var/log/*

RUN set -eux \
    && mkdir -p /var/run/frr \
    && chown -R frr:frr /etc/frr /var/run/frr

ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 179/tcp

COPY docker-start.sh /usr/lib/frr/docker-start.sh
CMD ["/usr/lib/frr/docker-start.sh"]
