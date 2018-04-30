# chikuwansible - my unique ubuntu environment maker

* This can make my unique ubuntu environment.
* Your using one task-file of this repository enable installing any program.

## Prepare Ansible

### Step1. Install Ansible

```
cd chikuwansible.git
source ./install_ansible.sh
```

OR

Read [this](https://qiita.com/miyagaw61/private/ca7eda54bbab392a8b78).

### Step2. Make /usr/bin/python

If you have no /usr/bin/python, you have to execute this command:
```
ln -s /usr/bin/python{version} /usr/bin/python
```

{version} is python version you have.

(example)
```
ln -s /usr/bin/python3.5 /usr/bin/python
```

### Step3. Enable SSH-Logining To Yourself Without Password

* You have private-key and public-key for ssh
* Your private-key and public-key is `-rw-------`
* You have ~/.ssh/authorized_keys for yourself

(example)
```
cd ~/.ssh
ssh-keygen -t rsa
chmod 600 id_rsa id_rsa.pub
ssh-copy-id localhost
```

### Step4. Check Your SSH-Logining To Yourself Without Password

```
ssh localhost
```

## Usage

### Step1. Edit "vars/editable.yml"

* "vars/editable.yml" is a file defining variables.
* You may have to edit this accordingly.

```
cd chikuwansible.git
vim vars/editable.yml
```

### Step2. Make A Playbook

* Make My Unique Environment
    * You have "make_my_environment.yml"

* Make Your Unique Environment
```
cd chikuwansible.git
vim make_your_environment.yml
```

* Tasks
    * apt_update_upgrade.yml
        * apt-update, apt-upgrade
    * apt.yml
        * apt-install my-favorite-packages
    * make_bashrc.yml
        * make my unique bashrc
    * install_latest_python.yml
        * install latest python and pip
    * install_latest_golang.yml
        * install latest golang
    * install_rust.yml
        * install rust
    * install_neovim.yml
        * install neovim and make my unique init.vim
    * install_rusgit.yml
        * install https://github.com/miyagaw61/rusgit
    * install_exa.yml
        * install https://github.com/ogham/exa
    * chown_files.yml
        * chown files
    * make_directories.yml
        * make my unique directories
