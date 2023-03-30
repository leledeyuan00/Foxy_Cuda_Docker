FROM osrf/ros:humble-desktop-full as base

RUN apt-get update && apt-get install -y lsb-release wget gnupg vim

# Install Gazebo
RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
RUN apt-get update && apt-get install -y gz-garden ros-humble-moveit ros-$ROS_DISTRO-rmw-cyclonedds-cpp

# ADD ROS2 Environment Config
COPY ROS2_config /root/ROS2_config
RUN touch /root/.bashrc && \
    echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "source /root/ROS2_config/ROS2_environment.bash" >> /root/.bashrc && \
    echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> /root/.bashrc
