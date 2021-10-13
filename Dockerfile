FROM cyberbotics/webots:R2021b-ubuntu18.04

RUN export AUDIODEV=null
RUN export DEBIAN_FRONTEND=noninteractive
RUN export DISPLAY=:99
RUN export LIBGL_ALWAYS_SOFTWARE=true
RUN Xvfb :99 -screen 0 1024x768x16 &

RUN apt update && apt-get install -y swig  python3.8-dev  python3-pip
RUN python3.8 -m pip install protobuf numpy opencv-python==4.1.* construct

ADD webots /usr/local/code/webots
ENV WEBOTS_HOME=/usr/local/code/webots

WORKDIR /usr/local/code/webots/src/controller/cpp
RUN make release
WORKDIR /usr/local/code/webots/projects/robots/robotis/darwin-op/libraries
RUN make release
ADD runner.py /usr/local/code
ADD motion.wbt /usr/local/code

ADD UnBeatables_Humanoid_Competition_Code /usr/local/code

WORKDIR /usr/local/code
ADD runner.sh /usr/local/code
ADD run.sh /usr/local/code
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10

CMD bash runner.sh
# CMD xvfb-run webots /usr/local/code/motion.wbt --stdout --stderr --batch --no-sandbox