#!/bin/bash
load_config() {
  echo "Waiting for Zookeeper to launch on 9983"
  while ! nc localhost 9983; do
    sleep 4
    echo "Waiting for Zookeeper to launch on 9983"
  done
  existing_configsets=$(curl http://localhost:8983/solr/admin/configs?action=LIST)
  echo existing configsets: $existing_configsets
  for d in $( ls /opt/solr/server/solr/configsets/); do
    if ! echo "$existing_configsets" | grep -q $d; then
      echo upload $d
      solr zk upconfig -z localhost:9983 -n $d -d /opt/solr/server/solr/configsets/$d &
    else 
      echo $d already present
    fi
  done
}

load_config&

USERID=$(id -u)
if [ $USERID -eq "0" ]
then
gosu solr solr-foreground -c
else
solr-foreground -c
fi	
