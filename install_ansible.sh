set -eu

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt upgrade -y
sudo apt install openssh-server -y
sudo apt install software-properties-common -y
sudo apt install ansible -y

if test ! -e /usr/bin/python ;then

echo "



==========================================
You probably have to execute this command:
==========================================
sudo ln -s /usr/bin/python{python_version} /usr/bin/python
"

fi

echo "



================================================
Can you SSH to yourself without password?
If not so, you may have to execute this command:
================================================
cd ~/.ssh
ssh-keygen -t rsa
chmod 600 {private_key} {public_key}
ssh-copy-id localhost
"
