# spark-in-docker
A dockerized spark cluster with conda environment using docker and docker compose.

Reference: [https://github.com/mvillarrealb/docker-spark-cluster]

## Pre-requisite
To build the cluster in docker, you need to have the following installed:
* docker
* docker compose

## Build docker images
To create cluster, simply do the following steps:
1. `chmod +x build-images.sh`
2. `./build-images.sh`

These will help you to create four docker images, namely:
1. spark-docker:2.4.3: a base image with jdk-8, spark-2.4.3, python3.6, miniconda3, and your customized conda environment installed.
2. spark-master:2.4.3: an image for creating the container of the master.
3. spark-worker:2.4.3: an image for creating the container of the worker.
4. spark-submit:2.4.3: an image for creating the container of submitting tasks in the cluster.

## Create docker containers
To create container with four images above, simply run:

`docker-compose up` 

at the root directory of this project. About docker compose, (from docker website):
> Docker Compose is a tool for defining and running multi-container Docker applications. 
> With Compose, you use a YAML file to configure your application’s services. 
> Then, with a single command, you create and start all the services from your configuration. 

It will create a master and two workers in the cluster (with the current setting), with a default bridge network. 
In the terminal, you could see IP address of the master node and the worker nodes.
You can check the status of the cluster with master's ip address (e.g.: `172.20.0.2`) + the master's webui port (default as `8080`, can be changed in the `dockers/master/Dockerfile`).

Also, you can use `docker ps` to check the active containers.


Tips:
`sudo docker-compose up` will run the containers as daemon. If you want to launch the container in interactive mode, 
where you can play within the container to debug or gain some insights, you could run in the terminal:
```
$ docker run -it \
             --name spark_master \
             --network spark_docker_spark_network \
             spark-master:2.4.3 \
             /bin/bash
```
(A bridge network should create before doing this by executing: `docker network create --driver bridge spark_network`)

## Resource Configuration
Computing resource allocation can be configured in `./env/spark-worker.sh`.


## My learning notes (continue to updating...)
This part is not necessary for you to read, only for self-learning...

### docker:
1. When creating your own image, try to reduce the size of the image. 
> If you need a JDK, consider basing your image on the official openjdk image, 
> rather than starting with a generic ubuntu image and installing openjdk as part of the Dockerfile (from docker official website).

2. ...







