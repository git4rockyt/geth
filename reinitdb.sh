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

LOG "Running reinit of geth"
sudo geth --identity "MyTestNetNode" --nodiscover --networkid 1999 --datadir /home/ubuntu/chaindata  init /home/ubuntu/CustomGenesis.json
if [ $? -ne 0 ]; then 
	ELOG "Cannot Contnue with reinit of geth"
fi

LOG "Starting geth with rpc an dbind addr of 0.0.0.0"
sudo geth --identity "MyTestNetNode" --datadir /home/ubuntu/chaindata --nodiscover --networkid 1999 --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcapi eth,web3,personal &
if [ $? -ne 0 ]; then 
	ELOG "Cannot start running geth"
fi

