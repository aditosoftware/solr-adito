FROM solr:8.4.0

EXPOSE 8983 9983

# Override lib extensions to replace log4j with version 2.17.0
USER root
RUN rm /opt/solr/server/lib/ext/*
COPY ./server_lib/ext/ /opt/solr/server/lib/ext/

USER solr
COPY ./solr_conf/solr.in.sh /etc/default/solr.in.sh
ADD ./start.sh /a/start.sh
ADD ./config/adito_config_v2/ /opt/solr/server/solr/configsets/adito_config_v2/
ADD ./config/adito_config_v3/ /opt/solr/server/solr/configsets/adito_config_v3/
ADD ./config/adito_config_v4/ /opt/solr/server/solr/configsets/adito_config_v4/
ADD ./config/adito_config_v5/ /opt/solr/server/solr/configsets/adito_config_v5/
ADD ./config/adito_config_v6/ /opt/solr/server/solr/configsets/adito_config_v6/
ADD ./config/adito_config_v7/ /opt/solr/server/solr/configsets/adito_config_v7/
ADD ./config/adito_config_v7.1.1/ /opt/solr/server/solr/configsets/adito_config_v7.1.1/
ADD ./plugin/lang-detection-plugin-1.4.2.jar/ /opt/solr/contrib/langid/lib/lang-detection-plugin-1.4.2.jar

CMD /bin/sh -c /a/start.sh
