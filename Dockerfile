# set base os image from https://github.com/fcwu/docker-ubuntu-vnc-desktop
FROM dorowu/ubuntu-desktop-lxde-vnc

# https://ask.fedoraproject.org/t/sudo-setrlimit-rlimit-core-operation-not-permitted/4223
RUN echo "Set disable_coredump false" >> /etc/sudo.conf


# Installing ROS2 via Devian packages from https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Install-Debians/#id10
RUN sudo apt update \
    && sudo apt install -y --no-install-recommends \
    curl \
    gnupg2 \
    lsb-release \
    python3-pip \
    vim \
    terminator \
    git \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*  
RUN sudo apt update
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN sudo apt update \
    && apt install -y ros-foxy-desktop \
    python3-rosdep \
    python3-colcon-common-extensions \
    ros-foxy-gazebo-ros-pkgs \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*
RUN sudo sh -c 'echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc'
RUN sudo rosdep init && rosdep update
RUN pip3 install -U argcomplete
