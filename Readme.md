# ROS Noetic Docker Environment

This repository contains a Dockerfile to build and run a Docker container for ROS Noetic development environment with support for the Foxglove Studio bridge.

## Prerequisites

- Docker
- XQuartz (I am using Mac - for GUI X11 forwarding)

## Build Docker Image

To build the Docker image, execute the following command:

```bash
sudo docker build -t ros1_ns -f ./Docker/Dockerfile .
```

# Run Docker Container

### Basic Run Command

```bash
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/src:/root/ros_ws/src -p 11311:11311 -p 8765:8765 -it --name ros1_ns_container ros1_ns bash
```

### Run with GPU Support

```bash
docker run --network=host --gpus all -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/src:/root/ros_ws/src --privileged -it --name ros1_ns_container ros1_ns bash
```

### Display issue : Fix

If any issues with Display, try changing ```DISPLAY=$DISPLAY``` to ```DISPLAY=host.docker.internal:0``` in the run command

```bash
docker run -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/src:/root/ros_ws/src -p 11311:11311 -p 8765:8765 -it --name ros1_ns_container ros1_ns bash
```

# Docker Exec

To execute commands within the running Docker container, you can use the following command:

```bash
docker exec -it ros1_ns_container bash
```

# Launch Foxglove Bridge Command

Once inside the Docker container, you can launch the Foxglove Bridge with the following command:

```bash
roslaunch --screen foxglove_bridge foxglove_bridge.launch port:=8765
```

This command launches the Foxglove Bridge with the specified port, enabling communication between your ROS nodes and Foxglove Studio.


# XQuartz - X11 forwarding

```bash
xhost +
```
Make sure to run this first in XQuartz before running the docker container which disables access control and allows any client from the network to connect to XServer.

-----------------------------------------------------
| Description              | Abbreviation           |
|--------------------------|------------------------|
| Docker Image Name        | ros1_ns                |
| Docker Container Name    | ros1_ns_container      |
| Docker File Path         | ./Docker/Dockerfile |
-----------------------------------------------------



