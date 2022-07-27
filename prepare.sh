#!/usr/bin/env bash

if ! $# -eq 2 ;then
    echo "Usage: $0 <root-password>"
    exit 1
fi
echo $1
exit 0
apt update -y
apt upgrade -y
apt install git -y
mkdir -p $HOME/src/github.com/miyase256/
cd $HOME/src/github.com/miyase256/
git clone https://github.com/miyase256/chikuwansible
cd chikuwansible 
./install_ansible.sh
echo $1 > .sudo_password.txt
echo vault > .vault_password.txt
./chikuwansible-vault init .sudo_password.txt .vault_password.txt
./get_editable_vars
echo ""
echo "====================="
echo ""
echo "make sure you have /usr/bin/python e.g. sudo ln -s /usr/bin/python{version} /usr/bin/python"
echo ""
