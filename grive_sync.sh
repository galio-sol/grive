#!/bin/bash
BASH_ENV=$HOME/.profile
LOG_FILE=/usr/local/var/grive.log
DOCKER_CONTAINER=grive2
GOOGLE_DRIVE=$HOME/GoogleDrive

trap "echo Exiting" EXIT
source $BASH_ENV

pid=$$

main() {
	echo "--------------------------"
	echo ${pid}::"$(date)"
	echo "${pid}::PATH:${PATH}"
	
	if [ ! -z "$1" ]
	then
		echo ${pid}::$1
	fi
	
	echo ${pid}::DOCKER_HOST::$DOCKER_HOST
	CONTAINER_ID="$(docker ps -q -f name=${DOCKER_CONTAINER})"
	
	if [ "$CONTAINER_ID" = "" ]
	then
		docker run --rm --name $DOCKER_CONTAINER -i -v $GOOGLE_DRIVE:/home/grive:rw -w /home/grive grive2:gt
	else
		echo ${pid}"::Container ${CONTAINER_ID} is already running"
	fi
}

if [ -z "$1" ]
then
  echo "No parameter provided"
  main >> $LOG_FILE 2>&1
else
  if [[ "$1" == "trunc"* ]]
  then
  	echo "Truncating the log"
    true > $LOG_FILE
    main >> $LOG_FILE 2>&1
  else
    echo "Appending to the log"
    main $1 >> $LOG_FILE 2>&1
  fi
fi
