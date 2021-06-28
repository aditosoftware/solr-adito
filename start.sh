#!/bin/bash
load_config() {
  echo "Waiting for Zookeeper to launch on 9983"
  while ! nc localhost 9983; do
    sleep 1
    echo "Waiting for Zookeeper to launch on 9983"
  done
  existing_configsets=$(curl http://localhost:8983/solr/admin/configs?action=LIST)
  echo $existing_configsets
  for d in $( ls /opt/solr/server/solr/configsets/); do
    if ! echo "$existing_configsets" | grep -q $d; then
      echo upload $d
      solr zk upconfig -z localhost:9983 -n $d -d /opt/solr/server/solr/configsets/$d &
    else 
      echo $d already present
    fi
  done
  if [ "$LOGLEVEL" != "ALL" ] && [ "$LOGLEVEL" != "TRACE" ] && [ "$LOGLEVEL" != "DEBUG" ] && [ "$LOGLEVEL" != "INFO" ] && [ "$LOGLEVEL" != "WARN" ] && [ "$LOGLEVEL" != "ERROR" ] && [ "$LOGLEVEL" != "FATAL" ] && [ "$LOGLEVEL" != "OFF" ]; then
    echo LOGLEVEL $LOGLEVEL not valid! Set LOGLEVEL to WARN
    LOGLEVEL="WARN"
  fi
  curl -s http://localhost:8983/solr/admin/info/logging --data-binary "set=root:$LOGLEVEL&wt=json" -o /dev/null
}

load_config&

USERID=$(id -u)
if [ $USERID -eq "0" ]; then
  gosu solr solr-foreground -c
else
  solr-foreground -c
fi
