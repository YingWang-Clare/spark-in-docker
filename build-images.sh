#!/bin/bash

set -e

# docker build -t spark-docker:2.4.3 ./dockers/base
docker build -t spark-master:2.4.3 ./dockers/master
docker build -t spark-worker:2.4.3 ./dockers/worker
docker build -t spark-submit:2.4.3 ./dockers/submit
