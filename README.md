# nfsen + nfdump in docker

* debian 12
* [nfsen](https://github.com/phaag/nfsen) version: 1.3.11
* [nfdump](https://github.com/phaag/nfdump) version: 1.7.1

## Run

```bash
git clone https://github.com/alekskomp/nfsen-docker.git
cd nfsen-docker
docker compose up -d
```

## Notes

`data` dir contains netflow files and settings.

`filters` dir contains saved search filters.

`fmt` dir contains saved output formats.

Web is listening on port `80` by default. Web basic auth login `admin`, password `netflow`. Change it in `Dockerfile` by `AUTH_USER` and `AUTH_PASS` vars.

Netflow is listening on port `9995` udp by default.

Timezone is `Europe/Moscow`. You can change it in `Dockerfile`.

BZ2 compression by default. You can change it in `nfsen-dist.conf` by `$ZIPcollected` and `$ZIPprofiles` vars.
