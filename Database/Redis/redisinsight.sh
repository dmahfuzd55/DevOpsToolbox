#!/bin/bash


# If you do not want to persist your Redis Insight data:
docker run -d --name redisinsight -p 5540:5540 redis/redisinsight:latest

#If you want to persist your Redis Insight data, first attach the Docker volume to the /data path and then run the following command:
docker run -d --name redisinsight -p 5540:5540 redis/redisinsight:latest -v redisinsight:/data