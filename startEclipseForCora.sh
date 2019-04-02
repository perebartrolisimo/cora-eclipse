#! /bin/bash

#USER=$1
USER=$(id -u -n)
BASEDIR=$(dirname $BASH_SOURCE)

echo starting eclipse using:
echo userName: $USER

if [ ! $USER ]; then
  	echo "You must specify the userName used when starting eclipse201903forcora1"
else
	#docker run --rm -ti --privileged --ipc=host --env="QT_X11_NO_MITSHM=1"  -e DISPLAY=$DISPLAY \
cd eclipse201903forcora1
#docker-compose run -e DISPLAY=$DISPLAY\
docker run --rm -ti --privileged --ipc=host --env="QT_X11_NO_MITSHM=1"  -e DISPLAY=$DISPLAY \
 -v /var/run/docker.sock:/var/run/docker.sock\
 -v /tmp/.X11-unix:/tmp/.X11-unix\
 -v INSTALLDIR/workspace:/home/$USER/workspace\
 -v INSTALLDIR/eclipse:/home/$USER/eclipse\
 -v INSTALLDIR/.eclipse:/home/$USER/.eclipse\
 -v PARENTDIR/m2:/home/$USER/.m2\
 -v PARENTDIR/eclipseP2:/home/$USER/.p2\
 -v PARENTDIR/.gitconfig:/home/$USER/.gitconfig\
 -e user=$USER\
 -p 9876:9876 \
 -p 8080:8080 \
 -p 8081:8081 \
 -p 8082:8082\
 -p 8090:8090 \
 -p 8091:8091 \
 -p 8092:8092 \
 --network=eclipseForCoraNet\
 --name eclipse201903forcora1\
 eclipse201903forcora1 $2
 cd ../
fi

#5432 postgresql (exposed directly from that container)
#9876 karma
#8080 tomcat
#8090 fitnesse
#8983 solr (exposed directly from that container)

#  -p 8080:8080 -p 9876:9876 -p 8090:8090 -p 8983:8983 -p 5432:5432\
