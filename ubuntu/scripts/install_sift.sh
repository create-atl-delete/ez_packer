#!/bin/bash

sudo apt-get update
sudo apt-get dist-upgrade

wget --quiet -O - https://raw.github.com/sans-dfir/sift-bootstrap/master/bootstrap.sh | sudo sh -s --