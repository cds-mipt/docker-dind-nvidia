FROM docker:20.10-dind

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    sudo \
    systemctl \
    curl \
    gpg \
    openssh-server \
    gnupg gnupg1 gnupg2 \
    tmux \
    mc \
    iproute2 \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup docker

RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
    && curl -s -L https://nvidia.github.io/libnvidia-container/experimental/$distribution/libnvidia-container.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
        sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
    && apt-get update \
    && apt-get install -y nvidia-docker2
    
# ROS Noetic
RUN apt-get update && apt-get install --no-install-recommends -y \
        gnupg \
        lsb-release \
        curl && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt-get update && apt-get install --no-install-recommends -y \
        ros-noetic-desktop-full \
        python3-rosdep \
        python3-rosinstall \
        python3-rosinstall-generator \
        python3-wstool \
        build-essential && \
    rosdep init && \
    rosdep update && \
    rm -rf /var/lib/apt/lists/*

ARG USER=raaicv
ARG UID=1000
ARG GID=1000
# default password
ARG PW=sirius

RUN useradd -m ${USER} --uid=${UID} -s /bin/bash \
    && echo "${USER}:${PW}" | chpasswd \
    && adduser ${USER} sudo \
    && adduser ${USER} docker \
    && cp /etc/skel/.bashrc /home/${USER} \
    && cp /etc/skel/.profile /home/${USER}

WORKDIR /home/${USER}
RUN cd /home/${USER} && mkdir -p catkin_ws/src && chown -R ${UID}:${GID} ./

EXPOSE 22
