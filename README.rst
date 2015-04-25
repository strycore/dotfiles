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

This setup uses some node tools, the recommended way of installing node.js
is through nvm. The zhrc file will assume that the latest version of node
is installed and aliased to 'default'. Using nvm instead of a system wide
install of node allows to install any version on any distribution without
having to add software repositories and, more importantly, allows to
install global node packages without requiring root access (and therefore
without running global node scripts as root).

    # Download and install nvm
    curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
    # Source nvm script to avoid restarting a shell
    . ./~nvm/nvm.sh
    # Install latest version of node (v0.12.2 as of this writing)
    nvm install v0.12.2
    # Alias this version of node to default
    nvm alias default v0.12.2

Installing python is done with pip. It is recommended not to install pip
with your distribution's package manager to keep a fresh version of the
program. One easy way to install the latest version of pip is with
easy_install::
    # easy_install is not installed on a base Ubuntu system
    sudo apt-get install python-setuptools
    # install pip
    sudo easy_install pip

This config ships with YouCompleteMe plugin which requires vim 7.4.
(Should now be in current distributions).

YouCompleteMe should be compiled automatically by vim-plug, if that
fails, you can compile it manually::

    sudo apt-get install cmake
    cd ~/.vim/plugged/YouCompleteMe
    ./install.sh --clang-completer

Additional programs are required for syntax checking:

- flake8, validates python code::
    sudo pip install flake8

- eslint, validates ecmascript code::
    npm install eslint -g

- rstcheck, validate RestructuredText files::
    sudo pip install rstcheck

Depending on the project being worked on, some additional software have to
be installed::
    npm install gulp -g
    npm install bower -g
    sudo pip install virtualenvwrapper
    sudo apt-get install silversearcher-ag
    sudo apt-get install exubrant-ctags
