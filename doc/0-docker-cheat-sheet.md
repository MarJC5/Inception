# Docker Cheat Sheet

## Build

Build an image from the Dockerfile in the
current directory and tag the image

```shell
docker build -t myimage:1.0 .
```

List all images that are locally stored with the Docker Engine

```shell
docker image ls
```

Delete an image from the local image store

```shell
docker image rm alpine:3.4
```

## Run

Run a container from the Alpine version 3.9
image, name the running container ``“web”`` and expose port 5000 externally,
mapped to port 80 inside the container.

```shell
docker container run --name web -p 5000:80 alpine:3.9
```

Stop a running container through SIGTERM

```shell
docker container stop web
```

Stop a running container through SIGKILL

```shell
docker container kill web
```

List the networks

```shell
docker network ls
```

List the running containers (add --all to include stopped containers)

```shell
docker container ls
```

Delete all running and stopped containers

```shell
docker container rm -f $(docker ps -aq)
```

Print the last 100 lines of a container’s logs

```shell
docker container logs --tail 100 web
```

## Share

Pull an image from a registry

```shell
docker pull myimage:1.0
```

Retag a local image with a new image name and tag

```shell
docker tag myimage:1.0 myrepo/myimage:2.0
```

Push an image to a registry

```shell
docker push myrepo/myimage:2.0
```

## Docker Management

All commands below are called as options to the base
docker command. Run ``docker <command> --help``
for more information on a particular command.

[Back to summary](/README.md)