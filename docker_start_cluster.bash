#!/bin/bash

export DOCKER_CONTAINERS=$1

if [ "$DOCKER_CONTAINERS" = "" ]
then

  echo "Usage: docker_setup_cluster.bash \$docker_container1,..,\$docker_container_n" 

else

  echo "The following containers are used:"


  for i in $( echo $DOCKER_CONTAINERS | sed s/,/\\n/g )
  do

    docker start $i
  done

  docker ps
fi

