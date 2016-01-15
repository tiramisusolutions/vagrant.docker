#!/bin/bash
# This script is used by vagrant to setup the test box



PACKAGES="htop git vim apt-transport-https"

# Update
echo "### Update Package Database ###"
apt-get update -y

# Install needed pakcages
echo "### Installing base Packages ###"
apt-get install -y $PACKAGES

# Install Docker
echo "### Installing Docker ###"
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

cat > /etc/apt/sources.list.d/docker.list << "EOF"
deb https://apt.dockerproject.org/repo debian-jessie main
EOF

apt-cache policy docker-engine
apt-get update
apt-get install -y docker-engine
gpasswd -a vagrant docker
service docker start


# Better .bashrc
echo "### Setting up bashrc ###"
wget https://raw.githubusercontent.com/leftxs/vagrant.docker/master/provisioning/roles/bash/files/bashrc -O /home/vagrant/.bashrc
source .bashrc
chown vagrant:vagrant .bashrc

# Vim
mkdir -p /home/vagrant/.vim
mkdir -p /home/vagrant/.vim/colors
wget -P /home/vagrant/.vim/colors https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

git clone https://github.com/gmarik/Vundle.vim.git /home/vagrant/.vim/bundle/Vundle.vim
chown -R vagrant:vagrant /home/vagrant/.vim

wget https://raw.githubusercontent.com/leftxs/vagrant.docker/master/provisioning/roles/vim/files/vimrc -O /home/vagrant/.vimrc
chown vagrant:vagrant /home/vagrant/.vimrc


echo "### I'm done, have fun ! :) ###"
