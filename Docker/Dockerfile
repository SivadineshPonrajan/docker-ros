# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set the ROS Noetic version
ENV ROS_DISTRO=noetic

# Set environment variables.
## Set non-interactive to prevent asking for user inputs blocking image creation.
ENV DEBIAN_FRONTEND=noninteractive
## Set timezone as it is required by some packages.
ENV TZ=Europe/Berlin

# Set the ROS root directory
ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}

# Install required packages
RUN apt-get update && apt-get install -y \
    lsb-release \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Add ROS repository and key
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    && chmod 644 /etc/apt/sources.list.d/ros-latest.list

# Add Gazebo repository and key
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/gazebo-latest.list \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key D2486D2DD83DB69272AFE98867170598AF249743 \
    && chmod 644 /etc/apt/sources.list.d/gazebo-latest.list

# Install essential tools, libraries, and ROS dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
        build-essential \
        git \
        python3-catkin-tools \
        python3-pip \
        ros-$ROS_DISTRO-foxglove-bridge \
        nano \
        curl \
        wget \
        net-tools \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        x11-apps \
        ros-noetic-rviz \
        ros-noetic-rqt \
        ros-noetic-rqt-common-plugins \
        ros-noetic-desktop-full \
        gazebo11 \
        ros-noetic-gazebo-ros-pkgs \
        ros-noetic-gazebo-ros-control \
        python3-rosdep \
        firefox \
        libyaml-cpp-dev \
        libpcap-dev \
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/*

# Add the source setup.bash command to the user's bashrc
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc

# Uncomment and run rosdep update and rosdep install if needed
RUN rosdep init && rosdep update --rosdistro $ROS_DISTRO

# Copy the ros_entrypoint.sh script from ros:ros-base
COPY Docker/ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh

# Set the ros_entrypoint.sh script as the entry point for the container
ENTRYPOINT ["/ros_entrypoint.sh"]

# Create a new workspace folder for ROS
RUN mkdir -p /root/ros_ws/src

# Set the new workspace folder as the working directory
WORKDIR /root/ros_ws