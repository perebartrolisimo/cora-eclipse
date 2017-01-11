#! /bin/bash

git clone https://github.com/olovm/cora-eclipse.git ~/workspace/cora-eclipse

chmod +x ~/workspace/cora-eclipse/docker/setupProjects.sh

~/workspace/cora-eclipse/docker/setupProjects.sh

cd ~/workspace/cora-jsclient/
npm install karma karma-chrome-launcher karma-firefox-launcher karma-qunit karma-coverage karma-html-reporter --save-dev

SWT_GTK3=0  ~/eclipse-installer/eclipse-inst