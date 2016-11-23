#!/bin/bash
cp -r /home/matthew/Eclipse/Projects/ORR-ME /home/matthew/git/
cd /home/matthew/git/ORR-ME
git add *
git commit
echo $1
git push
