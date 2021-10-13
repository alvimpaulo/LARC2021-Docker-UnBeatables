import subprocess
import io
import sys
from subprocess import PIPE, Popen
from threading import Thread
from queue import Queue, Empty

import time


def enqueue_output(out, queue):
    for line in iter(out.readline, b''):
        queue.put(line)
    out.close()


ON_POSIX = 'posix' in sys.builtin_module_names
p = Popen(['xvfb-run',  'webots', '/usr/local/code/motion.wbt', "--stdout",
           "--stderr", "--batch", "--no-sandbox"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, bufsize=1, close_fds=ON_POSIX)
q = Queue()
t = Thread(target=enqueue_output, args=(p.stdout, q))
t.daemon = True  # thread dies with the program
t.start()

time.sleep(5)

try:
    line = q.get_nowait()  # or q.get(timeout=.1)
except Empty:
    proc = subprocess.Popen(["bash","run.sh"], stdout=subprocess.PIPE)
    for lineOut in io.TextIOWrapper(proc.stdout, encoding="utf-8"):
        print("Saída do run.sh: {line}")
