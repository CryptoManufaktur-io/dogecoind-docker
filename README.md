# dogecoind-docker

dogecoind in docker-compose

To deploy:

`cp default.env .env`, and set the RPC username and password

Set `COMPOSE_FILE` if you are going to use an external network or a local traefik

`docker-compose up -d`

If there's a new release of dogecoind, pull it with `docker-compose build --no-cache`
