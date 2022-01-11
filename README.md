# dogecoind-docker

dogecoind in docker-compose

To deploy:

`cp default.env .env`, set `COMPOSE_FILE` if you are going to use an external network or a local traefik

`docker-compose run --rm rpcuser USERNAME`, then set the `RPCAUTH` variable in `.env`

`docker-compose up -d dogecoind`

If there's a new release of dogecoind, pull it with `docker-compose build --no-cache`
