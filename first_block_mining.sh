#!/bin/bash

LOG_FILE = $1

if [ -z $LOG_FILE ]; then 
        LOG_FILE="ethereum-install-`date +%Y-%b-%d-%H-%M-%S`.log"
fi

function LOG ( ) {

        echo "`date +%Y-%b-%d-%H-%M-%S` : $1" >> $LOG_FILE

}

function ELOG ( ) {

        echo "`date +%Y-%b-%d-%H-%M-%S` : ERROR: $1" >> $LOG_FILE

}

a="first"
while [ "$a" == "first" ]; do 
	echo "1" > /home/ubuntu/test1.txt; 
	sleep 10; 
	a="$(awk -F\"{|}" '{print $2}' /home/ubuntu/acctaddr.txt)"; 
	echo "$a" > /home/ubuntu/addr.txt; 
done
f [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

cat << EOF > /home/ubuntu/CustomGenesis.json
{
        "config":
                {
                        "chainId": 15,
                        "homesteadBlock": 0,
                        "eip155Block": 0,
                        "eip158Block": 0
                },
        "difficulty": "0x400",
        "gasLimit": "0x2100000",
        "alloc":
                { "$a" : { "balance": "400000" } }
}
EOF
if [ $? -ne 0 ]; then 
	ELOG  "Error Cannot Contnue with adding first block"
fi

