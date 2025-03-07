#!/bin/zsh
. ~/.zshrc
cd /root/catkin_ws
wstool init
wstool merge ./src/exploration/gbplanner_ros/packages_https_new.rosinstall
wstool update
catkin config -DCMAKE_BUILD_TYPE=Release
catkin build
echo "source /root/catkin_ws/devel/setup.zsh" >> ~/.zshrc
cd 
exec "$@"