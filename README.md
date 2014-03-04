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
