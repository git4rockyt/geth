export GIT_LOCATION="https://raw.githubusercontent.com/git4rockyt/geth/master/"

LOG_FILE="ethereum-install-`date +%Y-%b-%d-%H-%M-%S`.log"

function LOG ( ) {

	echo "`date +%Y-%b-%d-%H-%M-%S` : $1" >> $LOG_FILE

}

function ELOG ( ) {

	echo "`date +%Y-%b-%d-%H-%M-%S` : ERROR: $1" >> $LOG_FILE

}


LOG "Running apt-get update"

sudo apt-get update
if [ $? -ne 0 ]; then 
	ELOG "Cannot Contnue with apt-get update"
	exit -1
fi

LOG "Running apt-get upgrade"
sudo apt-get upgrade -y
if [ $? -ne 0 ]; then 
	ELOG "Cannot Contnue with apt-get upgrade"
	exit -1
fi

LOG "Installing Expect package"
sudo apt install expect -y
if [ $? -ne 0 ]; then 
	ELOG "Cannot Contnue with installing Expect package"
	exit -1
fi

LOG "Installing software-properties-common package"
sudo apt-get install software-properties-common
if [ $? -ne 0 ]; then 
	ELOG "Cannot Contnue with installing software-properties-common"
	exit -1
fi

LOG "Adding repo for ethereum"
sudo add-apt-repository -y ppa:ethereum/ethereum
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot Contnue with adding repo for ethereum"
	exit -1
fi

LOG "Running apt-get update"
sudo apt-get update
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot Contnue with apt-get update"
	exit -1
fi


LOG "Running apt-get install ethereum"
sudo apt-get install ethereum -y
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot Contnue with installing ethereum"
	exit -1
fi

LOG "Running apt-get install apache2"
sudo apt-get install apache2 -y
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot Contnue with installing apache2"
	exit -1
fi


LOG "Setting up Apache Test Page"
sudo wget -O /var/www/html/test.html ${GIT_LOCATION}test.html
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot Contnue with setting Apache page"
	exit -1
fi

LOG "Setting up Etherum software now"

LOG "Downloading password.txt file"
wget -O /home/ubuntu/password.txt ${GIT_LOCATION}password.txt
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot download password.txt file"
	exit -1
fi


LOG "Downloading CustomGenesis.json file"
wget -O /home/ubuntu/CustomGenesis.json ${GIT_LOCATION}CustomGenesis.json
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot download CustomGenesis.json file"
	exit -1
fi

LOG "Setting up Chaindata"
sudo mkdir /home/ubuntu/chaindata
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot Contnue making directory for chaindata"
	exit -1
fi

LOG "Downloading initdb.sh script"
wget -O initdb.sh ${GIT_LOCATION}initdb.sh
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot download initdb.sh script"
fi
chmod 755 initdb.sh

LOG "Executing initdb.sh script"
./initdb.sh $LOG_FILE


LOG "Downloading first_block_mining.sh script"
wget -O first_block_mining.sh ${GIT_LOCATION}first_block_mining.sh
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot download first_block_mining.sh script"
	exit -1
fi
chmod 755 first_block_mining.sh

LOG "Eexecuting first_block_mining.sh script"
./first_block_mining.sh $LOG_FILE

LOG "Downloading remdb.sh script"
wget -O remdb.sh ${GIT_LOCATION}remdb.sh
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot download remdb.sh script"
	exit -1
fi
chmod 755 remdb.sh

LOG "Executing remdb.sh script"
./remdb.sh $LOG_FILE


LOG "Killing all existing geth processes"
killall -9 geth
sleep 10

LOG "Downloading reinitdb.sh script"
wget -O reinitdb.sh ${GIT_LOCATION}reinitdb.sh
if [ $? -ne 0 ]; then 
	ELOG "Error Cannot download reinitdb.sh script"
	exit -1
fi
chmod 755 reinitdb.sh

LOG "Running reinitdb.sh script"
./reinitdb.sh $LOG_FILE





