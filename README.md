rflea-toolkit
=============

Install:

    wget https://raw.github.com/MobileLifeCentre/rFlea-toolkit/master/rflea.sh
    chmod +x rflea.sh
    ./rflea.sh install

The install exposes node-red and spacebrew as services (for example):

    start node-red
    stop spacebrew
    restart node-red

You can update directly using:

    ./rflea.sh update [spacebrew|node-red]


The installer has been tested in this distributions:
* Ubuntu 12.04.3 x32

If you encounter any problem drop us an email with your distribution.
