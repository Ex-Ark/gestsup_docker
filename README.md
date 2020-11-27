# About

This project bundles [Gestsup](https://gestsup.fr/) in a docker container with an already configured SQL database.

No configuration whatsoever is required to get started, as opposed to the Gestsup "classical" setup that requires you to setup an SQL server and fill a form at the project's start. 

It's as simple as :
```
git pull https://github.com/Ex-Ark/gestsup_docker.git
cd gestsup_docker
docker-compose up --build
```

Visit
`http://localhost:3010`

# How It's Made

This image uses [debian 10](https://hub.docker.com/_/debian/) (buster) as a base image and retrieve a release from Gestsup current stable.
`https://gestsup.fr/downloads/versions/current/stable/gestsup_3.X.X.zip`

The build stage installs the release & configures the system following instructions from [Gestsup documentation](https://gestsup.fr/index.php?page=support#44).

It then provides an entrypoint that directly configures the database using Gestsup internal install script.

The install script is then removed from the running image, as recommended per Gestsup.
# Gotchas

It uses docker named volumes to retain database data & app configuration across docker startups.

Accordingly, volumes data can be found on the host machine there :

| OS  | Container | Volume location |         
| :---------------: | :-----:| :-----:|
| Windows(WSL)  |   app        | \\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes\gestsup_docker_app-volume\\_data  |
| Windows(WSL)  |   mariadb             |   \\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes\gestsup_docker_mariadb-volume\\_data |
| Unix  | app          |    /var/lib/docker/volumes/gestsup_docker_app-volume/_data |
| Unix  | mariadb          |    //var/lib/docker/volumes/gestsup_docker_mariadb-volume/_data |

### /!\ 
Your volume data will be deleted in case you run
`docker-compose down -v`

It is recommended to backup regularly those files.
