#!/bin/bash

cd ../20.10
docker build -t docker:20.10 .
cd dind
docker build -t docker:20.10-dind .
cd ../../docker
docker build -t docker:20.10-dind-nvidia .
