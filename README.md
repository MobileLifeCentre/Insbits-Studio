rflea-toolkit
=============

Install:

    git clone https://github.com/MobileLifeCentre/rFlea-toolkit.git
    cd rFlea-toolkit
    chmod +x rflea.sh
    ./rflea.sh install

The install exposes node-red and spacebrew as services (for example):

    start node-red
    stop spacebrew
    restart node-red

You can update directly using:

    ./rflea.sh update [spacebrew|node-red]
