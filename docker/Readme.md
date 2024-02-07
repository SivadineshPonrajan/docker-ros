sudo docker-compose build

docker-compose up

docker exec -it ros1_ns_container bash

roslaunch --screen foxglove_bridge foxglove_bridge.launch port:=8765


sudo docker build -t ros1_ns -f DockerfileMac .
docker run --network=host -v $(pwd)/../src:/root/ros_ws/src --name ros1_ns_container ros1_ns
docker run -v $(pwd)/../src:/root/ros_ws/src -p 11311:11311 -p 8765:8765 --name ros1_ns_container ros1_ns