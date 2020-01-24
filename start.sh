    solr zk upconfig -z localhost:9983 -n adito_config_v2 -d adito_config_v2&
    solr zk upconfig -z localhost:9983 -n adito_config_v3 -d adito_config_v3&
    solr zk upconfig -z localhost:9983 -n adito_config_v4 -d adito_config_v4&

    solr-foreground -c