# Essa parte muda de pessoa pra pessoa
export WEBOTS_HOME=/usr/local/code/webots
export LD_LIBRARY_PATH=${WEBOTS_HOME}/lib/controller${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PYTHONPATH=${WEBOTS_HOME}/lib/controller/python38${PYTHONPATH:+:${PYTHONPATH}}
export PYTHONPATH=${WEBOTS_HOME}/lib/controller/python38_brew${PYTHONPATH:+:${PYTHONPATH}}
export PYTHONPATH=${WEBOTS_HOME}/projects/robots/robotis/darwin-op/libraries/python38/:${PYTHONPATH}
# Essa nao (mas talvez sim)
export LD_LIBRARY_PATH=${WEBOTS_HOME}/lib/controller${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=$WEBOTS_HOME/projects/robots/robotis/darwin-op/libraries/managers:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$WEBOTS_HOME/projects/robots/robotis/darwin-op/libraries/robotis-op2:$LD_LIBRARY_PATH


python3.8 ./unbeatables.py
# python3.9 ./main.py
