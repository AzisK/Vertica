# Run Vertica locally on Docker

Simply start the Vertica CE container by `docker-compose up` using the `docker-compose.yml` file provided in this repo.

Feel free to change variables in the YALM configuration. Few examples are elaborated below

- Login credentials can be seen here and they can be changed
- Feel free to change the version of the Vertica Docker image. More information can be found on the Vertica DockerHub [registry](https://hub.docker.com/r/vertica/vertica-ce).
- Uncomment volume mapping `./docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d` to run the init scripts when initiating the database

```zsh
docker-compose.yml
```
```yaml
version: '3.8'

services:
  vertica_ce:
    container_name: vertica_ce
    image: vertica/vertica-ce:10.1.1-0
    environment:
      - APP_DB_USER=vertica
      - APP_DB_PASSWORD=vertica
    ports:
        - 5433:5433
        - 5444:5444
    volumes:
      - vertica-data:/data
    #   - ./docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d  # Include this if you wish to have a custom database upon initialization
volumes:
  vertica-data:
```

 Have fun innovating!
