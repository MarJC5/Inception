## How Docker and docker compose work

Docker is a tool that allows you to run applications in a container. 

A `container` is a virtual environment that is isolated from the host machine.

This means that the container has its __own file system, its own network, and its own process tree__.

This allows you to run multiple applications on the same machine without them interfering with each other.

### how does it work?

Docker is a client-server application.
The client talks to the server, which does the heavy lifting of building, running, and distributing your Docker containers.

## The difference between a Docker image used with docker compose and without docker compose

When you use docker compose, you are using a `docker-compose.yml` file. This file contains the configuration for your application.

The `docker-compose.yml` file is used to configure your application’s services. Each service is configured using a `docker-compose.yml` file.

A `Docker image` is a template that contains the software and configuration required to run an application.

A `Docker container` is a running instance of a Docker image.

## The benefit of Docker compared to VMs

Most pros:

* Docker is faster than VMs
* Docker is more secure than VMs
* Docker is more lightweight than VMs
* Docker is more portable than VMs
* Docker is more efficient than VMs

Most cons:

* Docker is more difficult to monitor, maintain and troubleshoot than VMs (but this is not a problem if you use docker compose)
* Docker is more difficult to upgrade, patch, and update than VMs
* Docker is more difficult to backup, restore, and recover than VMs
* Docker is more difficult to integrate with other systems than VMs

## The pertinence of the directory structure required for this project (an example is provided in the subject's PDF file).

## How docker-network works

Docker networks are virtual networks that allow containers to communicate with each other and with the outside world.

Docker networks are isolated from each other and from the host machine.

Docker networks are created using the `docker network create` command.