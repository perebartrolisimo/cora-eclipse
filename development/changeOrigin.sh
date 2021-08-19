#! /bin/bash

workspaceDir=$1
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname $SCRIPT)

start(){
	setUser;
	chooseRepo;
	importProjectListing;
#	preventGitAskingForUsernameAndPasswordIfRepoIsMissing;
	changeOriginForAllRepositories;
	#setBasePathToPointToBasicStorageWorkspaceDirectoryInTomcatContextXml;
}

setUser(){
	if [ -z ${USER+x} ]; then 
		echo "USER is unset"; 
	else 
		echo "USER is set to '$USER'"; 
		user=$USER
		export user
	fi
}

chooseRepo(){
	echo ""
	echo "Please choose the remote you want to use as origin or enter a different one, "
	echo "where the cora projects have been cloned."
	echo "1. https://github.com/lsu-ub-uu/"
	echo "2. https://github.com/olovm/"
	echo "3. https://github.com/maddekenn/"
	echo "4. https://github.com/johandersson/"
	echo "5. https://github.com/perebartrolisimo/"
	echo "Choose 1, 2, 3, 4, 5 or enter your own base url to clone as origin. (eg. https://github.com/olovm/)"
	read -p "For origin, use? " userchoice
	case "$userchoice" in
	        1)
				echo "You choose: $userchoice 1"
	            originRepo="https://github.com/lsu-ub-uu/"
	            otherRepos="olovm maddekenn johandersson perebartrolisimo"
	            ;;
	        2)
				echo "You choose: $userchoice 2"
	            originRepo="https://github.com/olovm/"
	            otherRepos="lsu-ub-uu maddekenn johandersson perebartrolisimo"
	            ;;
	        3)
				echo "You choose: $userchoice 3"
	            originRepo="https://github.com/maddekenn/"
	            otherRepos="lsu-ub-uu olovm johandersson perebartrolisimo"
	            ;;
	        4)
				echo "You choose: $userchoice 4"
	            originRepo="https://github.com/johandersson/"
	            otherRepos="lsu-ub-uu olovm maddekenn perebartrolisimo"
	            ;;
	        5)
				echo "You choose: $userchoice 5"
	            originRepo="https://github.com/perebartrolisimo/"
	            otherRepos="lsu-ub-uu olovm maddekenn johandersson"
	            ;;
	        *)
				echo "You choose: $userchoice other"
	            originRepo="$userchoice"
	            otherRepos="lsu-ub-uu olovm maddekenn johandersson perebartrolisimo"
	esac
	
	echo "Origin choosen as: $originRepo"
	echo "Others remotes will be: $otherRepos"
}

importProjectListing() {
	.  $BASEDIR/projectListing.sh
}

preventGitAskingForUsernameAndPasswordIfRepoIsMissing() {
	#export GIT_ASKPASS="/bin/true"
	export GIT_TERMINAL_PROMPT=0
	unset SSH_ASKPASS
}

changeOriginForAllRepositories() {
	for PROJECT in $ALL; do
		removeAndSetNewOrigin $PROJECT
	done
}

removeAndSetNewOrigin() {
	local projectName=$1
	
	setWorkingRepositoryAndProjectNameAsTemp
	echo "tempRepository:$tempRepository"
	echo "tempProjectName:$tempProjectName"
	
	#cd $workspaceDir
#	git clone $tempRepository$tempProjectName.git $projectName
	cd $workspaceDir/$projectName
	git remote remove origin
	git remote add origin $tempRepository$tempProjectName.git
	cd $workspaceDir
}

setWorkingRepositoryAndProjectNameAsTemp(){
	tempProjectName=$projectName
	tempRepository=$originRepo

	if ! checkIfTempUrlExists; then 
		echo "- WARN - Chosen origin not found ($tempRepository$tempProjectName)"
		tryWithProjectNameWithoutCora
	fi
}

checkIfTempUrlExists(){
	echo "Check url:"
	echo "$tempRepository$tempProjectName"
	local status=$(lookupUrl $tempRepository$tempProjectName.git)
	echo $status
	if [  $status -eq 200 ]; then 
		return 0
	fi
	false
}

lookupUrl(){
	local url=$1
#	sta=$(curl -s --head $url --connect-timeout 3)
#	echo $sta 
	status=$(curl -s --head -w %{http_code} $url --connect-timeout 3 -o /dev/null)
	echo $status
}

tryWithProjectNameWithoutCora(){
	echo "Trying project name without cora..."
	tempProjectName=${projectName:5}

	if ! checkIfTempUrlExists; then 
		echo ""
	fi
}

setBasePathToPointToBasicStorageWorkspaceDirectoryInTomcatContextXml(){
	sed -i "s|WORKSPACEDIR|/home/$user/workspace|g" "$workspaceDir/cora-eclipse/oomph/Servers/Tomcat v10.0 systemOne-config/context.xml"
}

# ################# calls start here #######################################
if [ ! $workspaceDir ]; then
  	echo "You must specify the workspace directory.."
else
	start
fi
