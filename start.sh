#!/bin/bash
load_config(){
  echo "Waiting for Zookeeper to launch on 9983"
  while ! nc localhost 9983; do
    sleep 4
    echo "Waiting for Zookeeper to launch on 9983"
  done
  solr zk upconfig -z localhost:9983 -n adito_config_v2 -d /opt/solr/server/solr/configsets/adito_config_v2&
  solr zk upconfig -z localhost:9983 -n adito_config_v3 -d /opt/solr/server/solr/configsets/adito_config_v3&
  solr zk upconfig -z localhost:9983 -n adito_config_v4 -d /opt/solr/server/solr/configsets/adito_config_v4&
  solr zk upconfig -z localhost:9983 -n adito_config_v5 -d /opt/solr/server/solr/configsets/adito_config_v5&
  solr zk upconfig -z localhost:9983 -n adito_config_v6 -d /opt/solr/server/solr/configsets/adito_config_v6&
}
load_config&

USERID=$(id -u)
if [ $USERID -eq "0" ]
then
gosu solr solr-foreground -c
else
solr-foreground -c
fi
