sudo docker-compose build

docker-compose up

docker exec -it ros1_ns_container bash

roslaunch --screen foxglove_bridge foxglove_bridge.launch port:=8765

rostopic pub /chatter std_msgs/String "hello" -r 1

rostopic echo /chatter