#!/bin/bash
workingDir="/home/matthew/Eclipse/Projects/ORR-ME"
gitDir="/home/matthew/git/"
projectDirName="ORR-ME"

############################# Change Detection ############################
#return true if there are changes, return false if no changes.
#Detects changes by copying working dir to git dir, adding all files to index
# and then getting the git status of the repository.
function isChanged () {
#	echo "Made it to isChanged ()"
	local changedSuffex="anges to be committed:"
	local unchangedSuffex="thing to commit, working directory *"
	local remoteVar=$1
	cp -r "$workingDir" "$gitDir"
	cd "$gitDir/$projectDirName" || exit
	git add ./*
	status=$(git status | grep -w -e nothing -e committed)
	status=${status%$changedSuffex}
	status=${status%%$unchangedSuffex}
	case "$status" in
		'no')
			printf "There are no changes.\n"
			local return='false'
			;;
		'Ch')
			printf "Changes are Present.\n"
			local return='true'
			;;
		*)
			printf "Unknown result from status.  Exitting due to error.\n"
			printf "%s\n press return to exit" "$status"
			read
			exit
			;;
	esac
#	echo "$return"
	eval $remoteVar="'$return'"
}

############################# Commit Function #############################
#	 Checks the old files for changes before running commit command.  Then assuming all 
#  goes well will ask you if you want to push your project as well.
function commitBlock () {
isChanged changes
case "$changes" in
	'true')
		printf "Changes found, Starting commit process.\n"
			git commit
			read -r -p "Would you like to continue to Push? (y=yes, n=exit)"
			local newinput=$REPLY
			case "$newinput" in
				'y')
						pushBlock
						;;
				'n')
						input
						;;
				*)
    				printf "Error Incorect input.  Good Bye.\n"
						exit
						;;
			esac
			;;
		'false')
			printf "There are no changes to commit.\n"
			input
			;;
esac
}

############################ Pull Function ####################################
#Starts by running a commit with a default discription.  This may not be neccessary.
#Then pulls down the git version and copies it back over to the working dir.
#Could probably just copy and add without using the actuall commit.

function pullBlock() {
	cp -r /home/matthew/Eclipse/Projects/ORR-ME /home/matthew/git/
	cd /home/matthew/git/ORR-ME || exit
	git add ./*
	git commit -m "Adding before a Pull to prevent data loss."
	git push
	
	git pull
	cp -r /home/matthew/git/ORR-ME/* /home/matthew/Eclipse/Projects/ORR-ME/
}

########################### Push Block #######################################
#Simply pushes current commits up to the repository.
function pushBlock() {
	git push
}

########################## Auto Block ########################################
function autoRun () {
	isChanged changeStatus
	case "$chagneStatus" in 
		'true')
			commitBlock
			;;	
		'false')
			pullBlock
			;;
	esac
}

function input () {
#Asks what you want it to do and then will direct you to the correct block of code to preform that function.
read -r -p "Would you like to Push, Pull, or Commit your Project? (Hint: exit will end program)"
local currentAction=$REPLY
#echo "test"
#echo "$currentAction"
case "$currentAction" in
	'push')
			pushBlock
			;;
	"pull")
			pullBlock
			;;
	"commit")
			commitBlock
			;;
	"a")
			autoRun
			;;
	"auto")
			autoRun
			;;
	"exit")
			;;
	*)
			echo "Please try that input again!"
			input
			;;
esac
printf "Have a Nice Day.  Press Return to Exit>>"
read
exit
}

####################Where Program Starts############################
input
