#! /bin/bash

docker network disconnect eclipseForCoraNet eclipse202212forcora4

docker network create tempvpn

docker network connect tempvpn eclipse202212forcora4