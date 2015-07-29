# Webinar Demo

The following steps can be performed in order to show basic administrative tasks:

* Create the Docker instances 'couchbase-1', 'couchbase-2', 'couchbase-3'

```
docker run -d -P --name couchbase-1 couchbase
docker run -d -P --name couchbase-2 couchbase
docker run -d -P --name couchbase-3 couchbase
```

* Check the status of the instances

```
docker exec -it couchbase-1 /etc/init.d/couchbase-server status 
```

* Start/Stop instance 'couchbase-1'

```
docker exec -it couchbase-1 /etc/init.d/couchbase-server stop
docker exec -it couchbase-1 /etc/init.d/couchbase-server status
docker exec -it couchbase-1 /etc/init.d/couchbase-server start
docker exec -it couchbase-1 /etc/init.d/couchbase-server status
```

* Initialize a cluster by using the following script 

```
docker_setup_cluster.bash couchbase-1,couchbase-2,couchbase-3 couchbase couchbase 1024
```

Explain the contents of the script! 


* Get the port mapping for 'couchbase-1'

```
docker port couchbase-1
```

* Open a web browser by connecting to the docker host and the port which is mapped to 8091

```
e.g. http://ubuntu-server:32788
```

* Login with 'couchbase'/'couchbase'

* Show the Admin 'Cluster Overview', 3 nodes are part of the cluster


* Create a 4th Docker instance

```
docker run -d -P --name couchbase-4 couchbase
```

* Get the internal IP of this instance

```
docker exec -it couchbase-4 ifconfig
```

* Add the node via the Web-UI and rebalance

* Remove the node via the Web-UI and rebalance

* Under 'Data Buckets' create a bucket and explain the parameters

* Import some sample data

```
docker exec -it couchbase-1 /opt/couchbase/bin/cbdocloader -u couchbase -p couchbase -n 127.0.0.1:8091 -b demo /opt/couchbase/samples/beer-sample.zip
```

* Failover node 'couchbase-3'

* Then show the monitoring metrics and especially the vBucket count

* Recover and show the metric again

