#! /bin/bash
echo "Running copyMetadata..."
workspaceDir=$1

start(){
	copyMetadata;
}

copyMetadata(){
	#copyMetadataToSystemOne;
	copyMetadataToAlvin;	
	copyMetadataToDiVA;
}
copyMetadataToSystemOne(){
	#systemOne currently has no copied data, Cora data linked and updated from systemOne
	echo "tramse"
}
copyMetadataToAlvin(){
	rm $workspaceDir/metadata/alvin/cora -rf
	rm $workspaceDir/metadata/alvin/jsClient -rf
	rm $workspaceDir/metadata/alvin/systemOne -rf
	
	cp $workspaceDir/cora-metadata/files/cora $workspaceDir/metadata/alvin/cora -r
	cp $workspaceDir/cora-metadata/files/jsClient $workspaceDir/metadata/alvin/jsClient -r
	#temporaraly copy in  systemone
	cp $workspaceDir/systemone-metadata/files/systemOne $workspaceDir/metadata/alvin/systemOne -r
}

copyMetadataToDiVA(){
	rm $workspaceDir/metadata/diva/cora -rf
	rm $workspaceDir/metadata/diva/jsClient -rf
	rm $workspaceDir/metadata/diva/systemOne -rf
	
	cp $workspaceDir/cora-metadata/files/cora $workspaceDir/metadata/diva/cora -r
	cp $workspaceDir/cora-metadata/files/jsClient $workspaceDir/metadata/diva/jsClient -r
	#temporaraly copy in systemOne
	cp $workspaceDir/systemone-metadata/files/systemOne $workspaceDir/metadata/diva/systemOne -r
}

# ################# calls start here #######################################
if [ ! $workspaceDir ]; then
  	echo "You must specify the workspace directory.."
else
	start
fi
