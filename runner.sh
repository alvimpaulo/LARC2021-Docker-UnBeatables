#!/bin/bash

xvfb-run webots /usr/local/code/motion.wbt --stdout --stderr --batch --no-sandbox &

sleep 30

./run.sh
