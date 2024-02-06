#!/usr/bin/env python3

import rospy
from std_msgs.msg import String

def publisher():
    count = 0
    # Initialize the ROS node
    rospy.init_node('hello_node', anonymous=True)

    # Create a publisher for the /hello topic
    pub = rospy.Publisher('/hello', String, queue_size=10)

    # Set the publishing rate (in Hz)
    rate = rospy.Rate(1)  # 1 Hz

    while not rospy.is_shutdown():
        count = count + 1
        # Publish the "Hello, World!" message
        msg = String()
        msg.data = "Hello, World! "+str(count)
        pub.publish(msg)

        # Sleep to maintain the publishing rate
        rate.sleep()

if __name__ == '__main__':
    try:
        publisher()
    except rospy.ROSInterruptException:
        pass
