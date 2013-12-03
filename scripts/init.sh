#!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

VAGRANT=$ROOT_DIR/vagrant

rvm gemset create vagrant-cassandra-dev

# Install gemset file
bundle install

# Install chef libraries
cd $VAGRANT
librarian-chef install