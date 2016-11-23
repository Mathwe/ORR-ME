#!/bin/bash
cp -r /home/matthew/Eclipse/Projects/ORR-ME /home/matthew/git/
cd /home/matthew/git/ORR-ME
git add *
git status
$changes  git status | grep commit
$changes
read
git commit
echo $1
git push

#nothing to commit, working directory clean

