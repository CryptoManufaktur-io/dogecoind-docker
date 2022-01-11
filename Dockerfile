FROM debian:bullseye-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       jq \
       curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /dogecoin && curl -sSLf "$(curl -sSLf https://api.github.com/repos/dogecoin/dogecoin/releases/latest | jq -r '.assets[] | select(.name | endswith("x86_64-linux-gnu.tar.gz")).browser_download_url')" -o dogecoind.tar.gz \
  && tar xzf dogecoind.tar.gz -C /dogecoin --wildcards '*bin*' && find /dogecoin -type f -exec mv {} /usr/local/bin \; && rm -rf dogecoin dogecoind.tar.gz

ARG USER=dogecoin
ARG UID=12000

# See https://stackoverflow.com/a/55757473/12429735RUN
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/usr/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"

RUN mkdir -p /var/lib/dogecoin && chown -R ${USER}:${USER} /var/lib/dogecoin && chmod -R 700 /var/lib/dogecoin

USER ${USER}

ENTRYPOINT ["dogecoin-cli"]
