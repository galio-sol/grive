#!/bin/bash

if [ -z "$1" ]
then
  echo "No parameter provided"
else
  if [[ "$1" == "trunc"* ]]
  then
    echo "Truncating log"
  else
    echo $1
  fi
fi
