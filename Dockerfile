FROM ubuntu:14.04
RUN apt-get update 
RUN apt-get install --yes git
RUN mkdir /home/dev && mkdir /home/dev/ardupilot
WORKDIR /home/dev
RUN git clone https://github.com/3drobotics/PX4NuttX
RUN git clone https://github.com/3drobotics/PX4Firmware-solo
RUN mv ./PX4Firmware-solo ./PX4Firmware
RUN apt-get update && apt-get install --yes build-essential gcc-4.7-arm-linux-gnueabi
RUN apt-get update && apt-get install --yes gawk zip python-dev python-pip python-empy
RUN pip install catkin_pkg
RUN apt-get update && apt-get install --yes curl wget
RUN apt-get update && apt-get -y install lib32z1 lib32ncurses5 lib32bz2-1.0
WORKDIR /home
RUN wget https://launchpad.net/gcc-arm-embedded/4.7/4.7-2014-q2-update/+download/gcc-arm-none-eabi-4_7-2014q2-20140408-linux.tar.bz2
RUN tar xjf gcc-arm-none-eabi-4_7-2014q2-20140408-linux.tar.bz2
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/gcc-arm-none-eabi-4_7-2014q2/bin/
RUN apt-get update && apt-get install genromfs
ADD . /home/dev/ardupilot
WORKDIR /home/dev/ardupilot/ArduCopter
CMD make px4-v2