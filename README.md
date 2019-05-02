# QuantumBlack
QuantumBlack questions for platform team

### Write a Dockerfile for redis
* That uses the latest Ubuntu LTS Docker image as its base
* That accepts port configuration from an environment variable when the server
  is started
* That accepts memory limit configuration from an environment variable when the
  server is started
  
  
#Solution:
README:

The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use. We can specify the exact version in this case as Ubuntu 18.04

The problem states - that accepts port config from environment variable when server is started,
which is a bit counterintuitive. If the question means that during the build it can take environment vars that makes sense, because on a docker start, there is no environment variables allowed.

So I made an assumption that its is during docker run since that allows env vars to be passed.

Memory and port being passed via docker run
docker run -e "REDIS_PORT=6379" -e "MAX_MEMORY=2gb" -d redis

