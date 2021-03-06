#! /bin/bash

#USER=$1
USER=$(id -u -n)
BASEDIR=$(dirname $BASH_SOURCE)
ECLIPSEBRANCH=$2

echo 
echo "running startEclipseForCoraTempSetup.sh..."
echo starting eclipse using:
echo userName: $USER
echo cora-eclipse branch: $ECLIPSEBRANCH
echo 

if [ ! $USER ]; then
  	echo "You must specify the userName used when starting eclipse201909forcora4TempSetup"
else
cd eclipse201909forcora4
docker run --rm -ti --privileged --ipc=host --env="QT_X11_NO_MITSHM=1"  -e DISPLAY=$DISPLAY \
 -v /var/run/docker.sock:/var/run/docker.sock\
 -v /tmp/.X11-unix:/tmp/.X11-unix\
 -v INSTALLDIR/workspace:/home/$USER/workspace\
 -v INSTALLDIR/eclipse:/home/$USER/eclipse\
 -v INSTALLDIR/.eclipse:/home/$USER/.eclipse\
 -v PARENTDIR/m2:/home/$USER/.m2\
 -v PARENTDIR/eclipseP2:/home/$USER/.p2\
 -e user=$USER\
 -e eclipsebranch=$ECLIPSEBRANCH\
 --network=eclipseForCoraNet\
 --name eclipse201909forcora4TempSetup\
 eclipse201909forcora4
 cd ../
fi
# -p 8080:8080 -p 9876:9876 -p 8090:8090\
# -p 8081:8081\
# -p 8082:8082\
