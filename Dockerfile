FROM debian:bookworm-slim

RUN apt-get update \
  # && apt-get upgrade -y \
    && apt-get install -y \
                        postgresql-client-15 \
                        curl

RUN ARCH=$(uname -m) \
    && if [ "$ARCH" = "x86_64" ]; then \
        curl https://dl.min.io/client/mc/release/linux-amd64/mc --create-dirs -o /usr/local/bin/mc; \
    elif [ "$ARCH" = "aarch64" ]; then \
        curl https://dl.min.io/client/mc/release/linux-arm64/mc --create-dirs -o /usr/local/bin/mc; \
    fi \
    && chmod +x /usr/local/bin/mc

RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /backup

ADD backup.sh backup.sh

CMD ["sh", "backup.sh"]