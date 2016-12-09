#!/bin/sh
cd `dirname $0`
brew list > ./brewlist
brew cask list > ./brewcasklist
if [ $TMUX ]; then
  reattach-to-user-namespace mas list > ./maslist
else
  mas list > ./maslist
fi
