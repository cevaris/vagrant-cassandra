#!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
VAGRANT=$ROOT_DIR/vagrant


# Setup RVM
RUBY_GEMSET=$ROOT_DIR/.ruby-gemset
RUBY_VERSION=$ROOT_DIR/.ruby-version
rvm gemset create $(cat $RUBY_GEMSET)
rvm use "$(cat $RUBY_VERSION)@$(cat $RUBY_GEMSET)"


# Install Gemfile
bundle install


# Install chef libraries
cd $VAGRANT
librarian-chef install