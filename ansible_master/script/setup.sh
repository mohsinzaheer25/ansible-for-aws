#!/usr/bin/env bash

# Installing Packages for Ansible Setup
sudo apt-get update -y
sudo apt-get install software-properties-common
sudo apt-get-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install python python-pip awscli -y
sudo pip install --upgrade pip
sudo pip install boto ansible
sudo ln -s /usr/local/bin/ansible /usr/bin/ansible