Various config files for my Linux boxes
=======================================

Installation
------------

Run ./install.sh

If you're running the bundled oh-my-zsh config, run:

    vundle-init
    vundle-update

Otherwise run inside vim:

    :BundleInstall

Requirements
------------

A few packages are required for a fully working installation, get them with:

    sudo apt-get install build-essential cmake python-dev

This config ships with YouCompleteMe plugin which requires vim 7.4. (Should now 
be in current distributions).

Once the vim plugins are installed, YouCompleteMe must be compiled, run:

    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer
