#!/bin/bash
set -e
source /root/.bashrc

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --

if [ ! -e "CONTAINER_INITIALIZED_PLACEHOLDER" ]; then
    echo "-- First container startup --"
    catkin build
fi

source "/root/ros_ws/devel/setup.bash"
echo "Getting started"

roslaunch hello hello.launch

exec "$@"