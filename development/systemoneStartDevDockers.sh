#! /bin/bash

echo "starting solr"
docker run -d --name systemone-cora-solr \
--network=eclipseForCoraNet \
-p 38983:8983 \
cora-solr:1.0-SNAPSHOT \
solr-precreate coracore /opt/solr/server/solr/configsets/coradefaultcore
docker start systemone-cora-solr

#docker run -d --name systemone-docker-fedora --rm \
echo "starting fedora"
docker run -d --name systemone-docker-fedora \
-p 38087:8080 \
--network=eclipseForCoraNet \
--mount type=bind,source=/mnt/depot/cora/sharedArchive,target=/usr/local/tomcat/fcrepo-home/data/ocfl-root,bind-propagation=shared \
cora-docker-fedora:1.0-SNAPSHOT


#--volumes-from eclipse202203forcora2 \