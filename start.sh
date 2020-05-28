    solr zk upconfig -z localhost:9983 -n adito_config_v2 -d /opt/solr/server/solr/configsets/adito_config_v2&
    solr zk upconfig -z localhost:9983 -n adito_config_v3 -d /opt/solr/server/solr/configsets/adito_config_v3&
    solr zk upconfig -z localhost:9983 -n adito_config_v4 -d /opt/solr/server/solr/configsets/adito_config_v4&
    solr zk upconfig -z localhost:9983 -n adito_config_v5 -d /opt/solr/server/solr/configsets/adito_config_v5&

    solr-foreground -c