#!/bin/bash

export DOCKER_CONTAINERS=$1
export ADMIN_NAME=$2
export ADMIN_PWD=$3
export RAM_SIZE=$4

export CB_BIN=/opt/couchbase/bin/couchbase-cli

if [ "$DOCKER_CONTAINERS" = "" -o "$ADMIN_NAME" = "" -o "$ADMIN_PWD" = "" -o "$RAM_SIZE" = "" ]
then

  echo "Usage: docker_setup_cluster.bash \$docker_container1,..,$docker_container_n \$admin \$admin_pwd \$ram_size" 

else

  echo "The following containers are used:"

  count=0

  for i in $( echo $DOCKER_CONTAINERS | sed s/,/\\n/g )
  do

    DOCKER_IP=`docker exec -it $i /sbin/ifconfig | grep 'inet addr:' | grep -v 127.0.0.1 | cut -f2 -d':' | cut -f1 -d' '`

    echo Container: $i - $DOCKER_IP
  
	
    #The first node defines the cluster parameters
    if [ $count -eq 0 ]
    then
       
       export DOCKER_MASTER=$DOCKER_IP

       echo "Initializing a new cluster ..."
       docker exec -it $i $CB_BIN cluster-init -c $DOCKER_IP:8091\
       --cluster-init-username=$ADMIN_NAME --cluster-init-password=$ADMIN_PWD --cluster-init-ramsize=$RAM_SIZE\
       --cluster-init-port=8091

       sleep 7

    else
       echo "Joining the cluster ..."
       
       docker exec -it $i $CB_BIN rebalance -c ${DOCKER_MASTER}:8091 -u $ADMIN_NAME -p $ADMIN_PWD\
       --server-add=$DOCKER_IP:8091\
       --server-add-username=$ADMIN_NAME --server-add-password=$ADMIN_PWD
    fi

    let "count=count+1"
   
  done
fi

