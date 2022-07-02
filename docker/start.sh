#!/bin/bash

docker run -itd \
    --gpus all \
    -e "NVIDIA_DRIVER_CAPABILITIES=all" \
    -e "DISPLAY" \
    -e "QT_X11_NO_MITSHM=1" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --privileged \
    --name dind-nvidia \
    docker:20.10-dind-nvidia
