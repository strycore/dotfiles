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

This config ships with YouCompleteMe plugin which requires vim 7.4.
(Should now be in current distributions).

YouCompleteMe should be compiled automatically by vim-plug, if that
fails, you can compile it manually::

    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer

Additional programs are required for syntax checking:

- flake8, validates python code::
    sudo pip install flake8

- eslint, validates ecmascript code::
    npm install eslint -g

- rstcheck, validate RestructuredText files::
    sudo pip install rstcheck
