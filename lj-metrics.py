import datetime
import os
from time import sleep

from ping3 import ping

INTERVAL = int(os.environ.get("PING_INTERVAL","30"))
TOTAL_COUNT = int(os.environ.get("PING_COUNT","0"))
DESTINATION = os.environ.get("PING_DESTINATION","1.1.1.1")

count = 0
header = f"Pinging {DESTINATION} every {INTERVAL} secs"
print(header)

while count < TOTAL_COUNT:
    count += 1
    latency = ping(DESTINATION)

    if latency is None:
        latency_text = "PACKET DROPPED"
    elif latency is False:
        latency_text = "NO CONNECTION"
    else:
        latency_text = f"{latency} secs"

    line = f"{datetime.datetime.now()}: pinged {DESTINATION}; latency: {latency_text}"
    print(f"{line}")
  
    sleep(INTERVAL)
