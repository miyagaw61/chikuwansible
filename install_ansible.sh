set -eu

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt upgrade -y
sudo apt install openssh-server -y
sudo apt install software-properties-common -y
sudo apt install ansible -y

if test ! -e /usr/bin/python ;then

echo "============================="
echo "You must have /usr/bin/python"
echo "============================="

fi
