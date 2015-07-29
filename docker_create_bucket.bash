#!/bin/bash

export DOCKER_CONTAINER=$1
export BUCKET_NAME=$2
export BUCKET_PWD=$3
export BUCKET_SIZE=$4
export ADMIN_NAME=$5
export ADMIN_PWD=$6


if [ "$DOCKER_CONTAINER" = "" -o "$BUCKET_NAME" = "" -o "$BUCKET_PWD" = "" -o "$BUCKET_SIZE" = "" -o "$ADMIN_NAME" = "" -o "$ADMIN_PWD" = "" ]
then

  echo "Usage: docker_create_bucket.bash \$docker_container \$bucket_name \$bucket_pwd \$bucket_size \$admin \$admin_pwd" 

else

  echo "Creating bucket with name $BUCKET_NAME and size ${BUCKET_SIZE}MB in container $DOCKER_CONTAINER ..."

  #Create a bucket with default settings by waiting until the bucket is ready
  docker exec -it $DOCKER_CONTAINER /opt/couchbase/bin/couchbase-cli bucket-create\
  -c 127.0.0.1:8091\
  -u $ADMIN_NAME -p $ADMIN_PWD\
  --bucket=$BUCKET_NAME --bucket-password=$BUCKET_PWD --bucket-ramsize=$BUCKET_SIZE\
  --bucket-type=couchbase --bucket-port=11211 --bucket-replica=1 --wait
fi

