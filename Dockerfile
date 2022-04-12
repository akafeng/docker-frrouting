FROM debian:bullseye-slim

RUN set -eux \
    && apt-get update -qyy \
    && apt-get install -qyy --no-install-recommends --no-install-suggests \
        ca-certificates \
        apt-transport-https \
        curl \
        gnupg \
        lsb-release \
        tini \
    && rm -rf /var/lib/apt/lists/* /var/log/*

RUN set -eux \
    && curl https://deb.frrouting.org/frr/keys.asc | gpg --dearmor > /usr/share/keyrings/frr-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/frr-archive-keyring.gpg] https://deb.frrouting.org/frr/ $(lsb_release -s -c) frr-stable" | tee -a /etc/apt/sources.list.d/frr.list \
    && apt-get update -qyy \
    && apt-get install -qyy --no-install-recommends --no-install-suggests \
        frr \
        frr-pythontools \
    && rm -rf /var/lib/apt/lists/* /var/log/*

RUN set -eux \
    && mkdir -p /var/run/frr \
    && chown -R frr:frr /var/run/frr

ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 179/tcp

COPY docker-start.sh /usr/lib/frr/docker-start.sh
CMD ["/usr/lib/frr/docker-start.sh"]
