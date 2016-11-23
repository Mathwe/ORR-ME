#!/bin/bash
changedSuffex="anges to be committed:"
unchagnedSuffex="thing to commit, working directory *"
cp -r /home/matthew/Eclipse/Projects/ORR-ME /home/matthew/git/
cd /home/matthew/git/ORR-ME
git add *
git status
changes=$(git status | grep -w -e nothing -e committed)
echo "$changes"
changes=${changes%$changedSuffex}
changes=${changes%%$unchangedSuffex}
echo "${changes}"
read
git commit
echo $1
git push

#Your branch is ahead of 'origin/master' by 5 commits.
#  (use "git push" to publish your local commits)
#nothing to commit, working directory clean

#Your branch is ahead of 'origin/master' by 4 commits.
#  (use "git push" to publish your local commits)
#Changes to be committed:



