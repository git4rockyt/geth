#!/bin/bash

LOG_FILE=$1

if [ -z $LOG_FILE ]; then 
	LOG_FILE="ethereum-install-`date +%Y-%b-%d-%H-%M-%S`.log"
fi

function LOG ( ) {

	echo "`date +%Y-%b-%d-%H-%M-%S` : $1" >> $LOG_FILE

}

function ELOG ( ) {

	echo "`date +%Y-%b-%d-%H-%M-%S` : ERROR: $1" >> $LOG_FILE

}

LOG "Removing the old geth DB"
geth removedb --datadir /home/ubuntu/chaindata << EOF
y
y
EOF

if [ $? -ne 0 ]; then 
	ELOG "Cannot remove old DB"
fi

