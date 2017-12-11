sudo geth --identity "MyTestNetNode" --nodiscover --networkid 1999 --datadir ./chaindata  init ./CustomGenesis.json
if [ $? -ne 0 ]; then 
	echo "Error! Cannot Contnue"
fi


echo "Setting first block"
sudo geth --password /home/ubuntu/password.txt account new --datadir /home/ubuntu/chaindata > /home/ubuntu/acctaddr.txt
if [ $? -ne 0 ]; then 
	echo "Error! Cannot Contnue"
fi

