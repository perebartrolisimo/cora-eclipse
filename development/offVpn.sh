#! /bin/bash

docker network disconnect tempvpn eclipse202303forcora2

docker network rm tempvpn

docker network connect eclipseForCoraNet eclipse202303forcora2
