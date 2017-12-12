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


LOG "Setting up geth with CustomGenesis.json file"
sudo geth --identity "MyTestNetNode" --nodiscover --networkid 1999 --datadir ./chaindata  init ./CustomGenesis.json
if [ $? -ne 0 ]; then 
	ELOG "Cannot Contnue with geth initialization"
	exit -1
fi


LOG "Setting first account in the chain"
sudo geth --password /home/ubuntu/password.txt account new --datadir /home/ubuntu/chaindata > /home/ubuntu/acctaddr.txt
if [ $? -ne 0 ]; then 
	ELOG "Cannot Contnue with setting account"
	exit -1
fi

