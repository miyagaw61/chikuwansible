set -eu

sudo apt-add-repository ppa:ansible/ansible -y
sleep 2
sudo apt update -y
sleep 2
sudo apt upgrade -y
sleep 2
sudo apt install openssh-server -y
sudo apt install software-properties-common -y
sudo apt install ansible -y

if test ! -e /usr/bin/python ;then

echo "



========================================================
You probably have to execute this command:
  $ sudo ln -s /usr/bin/python{N} /usr/bin/python
========================================================

========================================================
Example:
  $ sudo ln -s /usr/bin/python3.5 /usr/bin/python
========================================================
"

fi

echo "



========================================================
You may have to execute this command:
   $ sudo vim ~/.ssh/config
========================================================

========================================================
Example:
  Host myself
  HostName localhost
========================================================
"
