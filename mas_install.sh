#!/bin/bash
TESTFILE="./maslist"
while read line; do
  masid=`echo $line | cut -d ' ' -f 1`
  mas install $masid
done < $TESTFILE
