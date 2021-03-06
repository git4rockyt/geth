#!/bin/bash

LOG_FILE=$1

if [ -z $LOG_FILE ]; then
	LOG_FILE="ethereum-install-`date +%Y-%b-%d-%H-%M-%S`.log"
fi

function LOG ( ) {

	echo "`date +%Y-%b-%d-%H-%M-%S` : $1" >> /home/ubuntu/$LOG_FILE

}

function ELOG ( ) {

	echo "`date +%Y-%b-%d-%H-%M-%S` : ERROR: $1" >> /home/ubuntu/$LOG_FILE

}


LOG "Setting up geth with CustomGenesis.json file"
geth --identity "MyTestNetNode" --nodiscover --networkid 1999 --datadir /home/ubuntu/chaindata  init /home/ubuntu/CustomGenesis.json
if [ $? -ne 0 ]; then
	ELOG "Cannot Contnue with geth initialization"
	exit -1
fi


LOG "Setting first account in the chain"
geth --password /home/ubuntu/password.txt account new --datadir /home/ubuntu/chaindata > /home/ubuntu/acctaddr.txt
if [ $? -ne 0 ]; then 
	ELOG "Cannot Contnue with setting account"
	exit -1
fi
