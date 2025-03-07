FROM osrf/ros:noetic-desktop-full
# this version is for deploying traversability analysis on NUC without GPU (No MMlab Framework) 

RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata

# install packages
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    tmux \
    wget \
    vim \
    netcat \
    iproute2 \
    iputils-ping \
    build-essential \
    software-properties-common \
    gdb \
    libc6-dbg \
    valgrind \
    python3.8 \
    python3-pip \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10 

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO noetic

# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

# Install zsh related
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t ys \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-history-substring-search \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    && echo "set-option -g default-shell /bin/zsh" >> ~/.tmux.conf \
    && chsh -s /bin/zsh

# install ros packages
RUN apt-get update && sudo apt-get install -y --no-install-recommends \
    libtool \
    python3-catkin-tools \
    libgoogle-glog-dev \
    ros-noetic-joy \
    ros-noetic-twist-mux \
    ros-noetic-interactive-marker-twist-server \
    ros-noetic-octomap-ros \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    mkdir -p /root/catkin_ws/src/exploration && \
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc && \
    echo "source /opt/ros/${ROS_DISTRO}/setup.zsh" >> ~/.zshrc

# setup entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh

# Set the default command to zsh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bin/zsh"]