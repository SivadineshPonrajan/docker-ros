#!/bin/bash
set -e
source /root/.bashrc

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --

if [ ! -e "CONTAINER_INITIALIZED_PLACEHOLDER" ]; then
    echo "-- First container startup --"
    catkin build
    touch "CONTAINER_INITIALIZED_PLACEHOLDER" # <== This placeholder file used in the github action to check when the build is done, do not remove
fi

source "/root/ros_ws/devel/setup.bash"
# roslaunch /root/ros_ws/src/start.launch # <== change to your launch file // comment out if you don't want auto launch

echo "Getting started"
roslaunch hello hello.launch

exec "$@"