sudo geth removedb --datadir /home/ubuntu/chaindata << EOF
y
y
EOF
if [ $? -ne 0 ]; then 
	echo "Error! Cannot Contnue"
fi

