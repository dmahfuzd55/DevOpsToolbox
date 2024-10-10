#!/bin/bash

# exec docker container
sudo docker exec -it 63d128dbcd94 /bin/bash

# nodejs convert container
sudo docker exec -it 63d128dbcd94 /bin/sh

# Copying a Directory (/usr/src/app) from Docker to Host:
sudo docker cp 63d128dbcd94:/usr/src/app /home/user/docker-data/

# Copying a Specific File (/usr/src/app/app.log) from Docker to Host:
sudo docker cp 63d128dbcd94:/usr/src/app/app.log /home/user/docker-logs/

# Check the size of a specific file
sudo docker exec -it 63d128dbcd94 du -h /usr/src/app/app.log