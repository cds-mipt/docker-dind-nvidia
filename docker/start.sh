#!/bin/bash

TEAM=$1

mkdir /home/belkin/$TEAM

SSH_PORT=$(($UID * 10 + $TEAM))

echo "SSH_PORT=$SSH_PORT"

docker run -it -d \
     --privileged \
     --gpus all \
     --ipc host \
     -e NVIDIA_DRIVER_CAPABILITIES=all \
     -e DOCKER_TLS_CERTDIR=/certs \
     -e TERM=xterm-256color \
     -v /mnt/lv1/datasets/:/datasets:rw \
     -v /home/belkin/$TEAM/home:/home/rdls/:rw \
     -p $SSH_PORT:22 \
     --name rdls-$TEAM \
     --hostname dgxa100-$TEAM \
     docker:20.10-dind-nvidia

sleep 2
docker exec rdls-$TEAM chgrp docker /var/run/docker.sock
docker exec rdls-$TEAM /etc/init.d/ssh start
docker exec rdls-$TEAM chown -R rdls:rdls /home/rdls
docker exec rdls-$TEAM chown -R rdls:rdls /datasets
docker exec rdls-$TEAM chmod -R 777 /datasets
docker exec rdls-$TEAM cp /etc/skel/.bashrc /home/rdls
docker exec rdls-$TEAM cp /etc/skel/.profile /home/rdls
