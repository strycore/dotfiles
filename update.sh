#!/usr/bin/env bash

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update

sudo pip install --upgrade virtualenvwrapper pysmell flake8

