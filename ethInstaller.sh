export GIT_LOCATION="https://raw.githubusercontent.com/git4rockyt/geth/master/"

echo "Installing base packages"

sudo apt-get update
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

sudo apt-get upgrade -y
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

sudo apt install expect -y
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

sudo apt-get install software-properties-common
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

sudo add-apt-repository -y ppa:ethereum/ethereum
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

sudo apt-get update
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi


echo "Installing Ethereum Software"
sudo apt-get install ethereum -y
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

echo "Setting up Apache Test Page"
wget -O /var/www/html/test.html ${GIT_LOCATION}test.html
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

echo "Setting up Etherum"

echo "Downloading Genesis json"
wget -O /home/ubuntu/CustomGenesis.json ${GIT_LOCATION}CustomGenesis.json
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

echo "Setting up Chaindata"
sudo mkdir /home/ubuntu/chaindata
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi
wget -O initdb.sh ${GIT_LOCATION}initdb.sh
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi
chmod 755 initdb.sh
./initdb.sh


wget -O first_block_mining.sh ${GIT_LOCATION}first_block_mining.sh
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi
chmod 755 first_block_mining.sh

./first_block_mining.sh


wget -O remdb.sh ${GIT_LOCATION}remdb.sh
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi

chmod 755 remdb.sh
./remdb.sh

wget -O reinitdb.sh ${GIT_LOCATION}reinitdb.sh
if [ $? -ne 0 ]; then 
	echo "Error Cannot Contnue"
fi
chmod 755 reinitdb.sh
./reinitdb.sh





