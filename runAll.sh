#! /bin/bash

USER=$(id -u -n)
USERID=$(id -u)
DOCKERGROUPID=$1

echo 
echo running all using:
echo userName: $USER
echo userId: $USERID
echo dockerGroupId: $DOCKERGROUPID


if [ ! $USER ]; then
  	echo you must specify the userName to be used when building eclipse201903forcora2
elif [ ! $USERID ]; then
	echo you must specify the userid to be used when building eclipseforcoraphoton, use: id -u youruserid 
elif [ ! $DOCKERGROUPID ] && [ ! -d ./eclipseForCora ]; then
	echo you must specify the dockergroupid to be used when building eclipse201903forcora2, use: getent group docker 
else
	if [ ! -d ./eclipse201903forcora2 ]; then
		./cora-eclipse/buildEclipseForCora.sh $USER $USERID $DOCKERGROUPID
		./cora-eclipse/setupDirectoriesAndScriptsForEclipseForCora.sh
		docker network create eclipseForCoraNet
		docker network create eclipseForAlvinNet
		docker network create eclipseForDivaNet
	fi
#	./eclipseForCora/startEclipseForCora.sh $USER
	./eclipse201903forcora2/startEclipseForCoraTempSetup.sh $USER
fi