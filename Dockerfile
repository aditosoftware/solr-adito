FROM solr:8.4.0

EXPOSE 8983 9983

ADD ./start.sh /a/start.sh
ADD ./config/adito_config_v2/ /opt/solr/server/solr/configsets/adito_config_v2/
ADD ./config/adito_config_v3/ /opt/solr/server/solr/configsets/adito_config_v3/
ADD ./config/adito_config_v4/ /opt/solr/server/solr/configsets/adito_config_v4/
ADD ./plugin/lang-detection-plugin-1.4.2.jar/ /opt/solr/contrib/langid/lib/lang-detection-plugin-1.4.2.jar

RUN chmod u+x /a/start.sh

CMD /a/start.sh
