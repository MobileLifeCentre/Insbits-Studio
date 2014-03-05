#!/bin/bash
# rflea installer variables
SPACEBREW_GIT=https://github.com/MobileLifeCentre/spacebrew.git
NODERED_GIT=https://github.com/MobileLifeCentre/node-red.git
INSTALL_DIRECTORY=/var/www
SPACEBREW_SERVICE_DIRECTORY=/etc/init/spacebrew.conf
NODERED_SERVICE_DIRECTORY=/etc/init/node-red.conf

# functions
install(){
        mkdir -p $INSTALL_DIRECTORY
        cd $INSTALL_DIRECTORY
        
        apt-get update
        apt-get install -y g++ curl libssl-dev apache2-utils git make mongodb-server

        # node
        echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bashrc
        PATH=$HOME/local/bin:$PATH
        . ~/.bashrc
        mkdir ~/local
        mkdir ~/node-latest-install
        cd ~/node-latest-install
        curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
        ./configure --prefix=~/local
        make install

        # npm
        wget https://npmjs.org/install.sh
        chmod +x install.sh
        ./install.sh

        cd $INSTALL_DIRECTORY

        echo "Downloading Spacebrew"
        git clone $SPACEBREW_GIT

        echo "Downloading Node-red"
        git clone $NODERED_GIT

        echo "Installing Spacebrew"
        cd ${INSTALL_DIRECTORY}/spacebrew
        npm install

        echo "Installing Node-red"
        cd ${INSTALL_DIRECTORY}/node-red
        npm install

        echo "Setting services"
        cd $INSTALL_DIRECTORY
        cp ./spacebrew/spacebrew.conf $SPACEBREW_SERVICE_DIRECTORY
        chmod +x /etc/init/spacebrew.conf
        cp ./node-red/node-red.conf $NODERED_SERVICE_DIRECTORY
        chmod +x /etc/init/node-red.conf

        echo "Starting services"
        start spacebrew
        start node-red

        echo "Install finished"
}
uninstall() {
        echo "Stopping services"
        stop spacebrew
        stop node-red
        cd $INSTALL_DIRECTORY
        echo "Removing files"
        rm -R ${INSTALL_DIRECTORY}/node-red
        rm -R ${INSTALL_DIRECTORY}/spacebrew
        rm /etc/init/node-red.conf
        rm /etc/init/spacebrew.conf

        echo "Uninstall finished"
}
update_spacebrew() {
        echo "Updating spacebrew"
        cd ${INSTALL_DIRECTORY}/spacebrew
        git pull
        restart spacebrew
}

update_nodered() {
        echo "Updating node-red"
        cd ${INSTALL_DIRECTORY}/node-red
        git pull
        restart node-red
}

update() {
        if [ "$2" = "spacebrew" ]
        then
                update_spacebrew
        elif [ "$2" = "node-red" ]
        then
                update_nodered
        else
                update_spacebrew
                update_nodered
        fi

        echo "Update finished"

}

print_instructions() {
        echo "This are the available options:"
        echo " install"
        echo " update [spacebrew|node-red]"
        echo " uninstall"
}

# logic
initial_directory=`pwd`
echo $initial_directory

if [ "$1" = 'install' ]
then
        install
elif [ "$1" = 'update' ]
then
        update
elif [ "$1" = 'uninstall' ]
then
        uninstall
else
        print_instructions
fi

cd $initial_directory
exit 1
