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
1. Docker is an open source tool that makes it easier to create, distribute, and run the application. Containers provide the benefits of a virtual machine like isolation between applications running on the same machine.

2. When creating your own image, try to reduce the size of the image. 
> If you need a JDK, consider basing your image on the official openjdk image, 
> rather than starting with a generic ubuntu image and installing openjdk as part of the Dockerfile (from docker official website).

3. Container Image is a packaging format that includes not only your application but all your dependencies or runtime information required to run it.

4. Container & VM: Two separate virtual machines running on one machine actually run two whole different OSes. Multiple containers run the same OS since containers are logical construct we use within the OS. That makes it so light-weight.

5. Dockerfiles are text documents that contain all of the necessary steps for building an image from the command line.

### Kubernetes:
1. Computing is trending from:
Metal PC -> VM -> Containers

2. Container packaging is only 5% of the problem. The other parts are:
* App configuration
* Service Discovery
* Managing updates
* Monitoring
The platform to manage all these is kubernetes.

3. The core of kubernetes is pods. Pods represent a logical application. Pods represent and hold a collection of one or more containers. Generally, if you have multiple containers with a hard dependency on each other, they would be packaged together inside of a single pod.

4. Pods also have volumes. Volumes are just data divs that live as long as the pod lives and can be used by any of the containers in that pod. The containers inside the same pod can communicate with each other, and they also share the attached volumes. Pods also share a network namespace, which means the pod has one IP per pod.

5. Pods are allocated a private IP address by default and cannot be reached outside of the cluster.

6. Monitoring and Health Checks:
Sometimes a container on a pod can be up and running but the application inside of the container might be malfunctioning. Kubernetes has built-in support to make sure that your application is running correctly with user implemented application health and readiness checks.

* Readiness probes indicate when a pod is ready to serve traffic. If a readiness check fails then the container will be marked as not ready and will be removed from any load balancers.

* Liveness probes indicate a container is alive. If a liveness probe fails several times, then the container will be restarted. 

7. Secrets and Configmaps: Many apps require configuration settings in secret such as TLS certs to run in a production environment. In kubernetes, there are Configmaps and Secrets to take care of these problems. They are similar except that Configmaps don’t have to be sensitive data. They can use environment variables and they can tell downstream pods that configuration is changed along with a pod or restart itself if necessary. We can start up a pod that uses a secret. The secret is mounted onto the pod as a volume. Once that the volume is there, we can take the contents of it and expose it on the file system to wherever our pods would go to mount it. Then the pod starts to come online.

8. Services:
Instead of relying on pod IP addresses which change, kubernetes provide services as a stable endpoint for pods. The pods that the service exposes are based on a set of labels. If pods have the correct labels, they are automatically picked up and exposed by our services. The level of access the service provides to a set of pods depends on the type of the services. Currently, there are three types:
* Cluster IP, which is internal only.
* Node port, which gives each node an external IP that’s accessible.
* Load balancing, which adds a load balancer from the cloud provider which forced traffic from the service to nodes within it.









