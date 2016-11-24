#!/bin/bash
changedSuffex="anges to be committed:"
unchangedSuffex="thing to commit, working directory *"


function commitBlock () {
cp -r /home/matthew/Eclipse/Projects/ORR-ME /home/matthew/git/
cd /home/matthew/git/ORR-ME
git add *
git status
changes=$(git status | grep -w -e nothing -e committed)
changes=${changes%$changedSuffex}
changes=${changes%%$unchangedSuffex}
echo "$changes"
case "$changes" in
	'no')
			printf "There are no changes to commit."
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

function input () {
#Asks what you want it to do and then will direct you to the correct block of code to preform that function.
read -p "Would you like to Push, Pull, or Commit your Project?"
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
