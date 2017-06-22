#!/bin/bash

xhost local:root
docker run --name=spotify_client --rm=true --net=host --device /dev/snd --env DISPLAY --volume $HOME:/root --volume /dev/shm:/dev/shm --volume /tmp:/tmp --volume /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket yammelvin/spotify-client

