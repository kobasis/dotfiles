#!/bin/sh
set -eu

DIR=`dirname $0`
BASENAME=`basename $0`
cd $DIR
brew update
brew upgrade
brew-file init -y
git add .
git commit -m "weekly"
git push
terminal-notifier  -title $BASENAME  -message "FINISHED!"
