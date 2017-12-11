sudo geth --identity "MyTestNetNode" --nodiscover --networkid 1999 --datadir /home/ubuntu/chaindata  init /home/ubuntu/CustomGenesis.json
if [ $? -ne 0 ]; then 
	echo "Error! Cannot Contnue"
fi

sudo geth --identity "MyTestNetNode" --datadir /home/ubuntu/chaindata --nodiscover --networkid 1999 --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcapi eth,web3,personal
if [ $? -ne 0 ]; then 
	echo "Error! Cannot Contnue"
fi

