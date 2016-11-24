#!/bin/bash
changedSuffex="anges to be committed:"
unchangedSuffex="thing to commit, working directory *"

############################# Commit Function #############################
#  This block copies my working directory to the git directory.  Then adds all new files.
#	 Checks the old files for changes before running commit command.  Then assuming all 
#  goes well will ask you if you want to push your project as well.
function commitBlock () {
cp -r /home/matthew/Eclipse/Projects/ORR-ME /home/matthew/git/
cd /home/matthew/git/ORR-ME
git add *
#git status
changes=$(git status | grep -w -e nothing -e committed)
changes=${changes%$changedSuffex}
changes=${changes%%$unchangedSuffex}
#echo "$changes"
case "$changes" in
	'no')
			printf "There are no changes to commit.\n"
			input
			;;
	'Ch')
			printf "Changes found, Starting commit process.\n"
			git commit
			read -p "Would you like to continue to Push? (y=yes, n=exit)"
			newinput=$REPLY
			case "$newinput" in
				'y')
						pushBlock
						;;
				'n')
						exit
						;;
				*)
						printf "Error Incorect input.  Good Bye.\n"
						exit
						;;
			esac
			;;
	*)
			printf "Critical Error Encountered when parsing changes.  Press Return to exit>>"
			read
			exit
			;;
esac

}

############################ Pull Function ####################################


function pullBlock() {
	
}

function input () {
#Asks what you want it to do and then will direct you to the correct block of code to preform that function.
read -p "Would you like to Push, Pull, or Commit your Project? (Hint: exit will end program)"
currentAction=$REPLY
echo "test"
echo "$currentAction"
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
			;&
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
