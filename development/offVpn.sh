#! /bin/bash

docker network disconnect tempvpn eclipse202209forcora4

docker network rm tempvpn

docker network connect eclipseForCoraNet eclipse202209forcora4
