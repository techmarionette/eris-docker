# eris-docker

> Version: v0.36.7

Docker image for Eris. To load the docker file use:

```bash
docker load --input eris-docker.tar
```

The first run of Eris against an empty Neo4j instance will build the database
schema and structure required. It will also set the root passphrase which is 
set using the `-p` option:

```
docker run --rm -p8080:8080 eris:latest -c config.json -p "${PASSPHRASE}"
```

Subsequent runs of Eris can omit the `-p` option:

```
docker run --rm -p8080:8080 eris:latest -c config.json
```

A complete example config.json with default values is provided in this 
repository, along with a minimal configuration file. Configuration options are
given in [config.md](./config.md)
