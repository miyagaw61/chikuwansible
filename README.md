# chikuwansible - my unique ubuntu environment maker

* This can make my unique ubuntu environment.
* Your using one task-file of this repository enable installing any program.

## Prepare Ansible

### Step1. Install Ansible

If you are ubuntu, try this command:

```
$ sudo ./install_ansible.sh
```

If not, you have to read [this](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-the-control-machine).

### Step2. Make /usr/bin/python

If you have no /usr/bin/python, you have to execute this command:
```
$ sudo ln -s /usr/bin/python{version} /usr/bin/python
```

{version} is python version you have.

(example)
```
$ sudo ln -s /usr/bin/python3.5 /usr/bin/python
```

### Step3. Check

Please check whether you can use ansible or not.  
But if you can't use ping (e.g. can't use ICMP), this test will probably fail.

```
$ cd chikuwansible.git
$ ansible-playbook test.yml

PLAY [localhost] *************************************************************************************

TASK [Ping to localhost] *****************************************************************************
ok: [localhost]

PLAY RECAP *******************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0
```

## Usage

### Step1. Edit "vars/editable.yml"

* "vars/editable.yml" is a file defining variables.
* You may have to edit this accordingly. (especially, `Probably you have to edit these` group)

```
$ cd chikuwansible.git
$ vim vars/editable.yml
```

* You can use `get_editable_vars` command

```
$ ./get_editable_vars

#######################################
[+] python3_pyenv_version
#######################################

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

python3.8/focal-updates,focal-security,now 3.8.10-0ubuntu1~20.04.4 amd64 [installed,automatic]
python3.9/focal-updates,focal-security 3.9.5-3ubuntu0~20.04.1 amd64

#######################################
[+] llvm_version
#######################################

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

llvm-10-dev/focal,now 1:10.0.0-4ubuntu1 amd64 [installed,automatic]
llvm-11-dev/focal-updates 1:11.0.0-2~ubuntu20.04.1 amd64
llvm-12-dev/focal-updates,focal-security,now 1:12.0.0-3ubuntu1~20.04.5 amd64 [installed,automatic]
llvm-6.0-dev/focal 1:6.0.1-14 amd64
llvm-7-dev/focal 1:7.0.1-12 amd64
llvm-8-dev/focal 1:8.0.1-9 amd64
llvm-9-dev/focal 1:9.0.1-12 amd64

#######################################
[+] golang_version
#######################################
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
 26 1085k   26  283k    0     0   128k      0  0:00:08  0:00:02  0:00:06  128kgo1.18.3.linux-amd64.tar.gz
go1.18.3.linux-amd64.tar.gz
go1.18.3.linux-amd64.tar.gz
go1.18.3.linux-amd64.tar.gz
go1.17.11.linux-amd64.tar.gz
go1.17.11.linux-amd64.tar.gz
go1.18.2.linux-amd64.tar.gz
go1.18.2.linux-amd64.tar.gz
go1.18.1.linux-amd64.tar.gz
go1.18.1.linux-amd64.tar.gz
 73 1085k   73  792k    0     0   159k      0  0:00:06  0:00:04  0:00:02  161k
 curl: (23) Failed writing body (656 != 1408)

#######################################
[+] global_version
#######################################
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
100 17346    0 17346    0     0  18031      0 --:--:-- --:--:-- --:--:-- 18012
global-6.6.7.tar.gz
global-6.6.7.tar.gz
global-6.6.8.tar.gz
global-6.6.8.tar.gz
global-6.6.8.tar.gz
global-6.6.8.tar.gz
global-6.6.tar.gz
global-6.6.tar.gz
global-6.6.tar.gz
global-6.6.tar.gz

#######################################
[+] your config
#######################################
# Probably you have to edit these
# =============================================
git_user: "miyase256"
user: "miya"
python3_pyenv_version: "3.9.0"
llvm_version: "12"
golang_version: "1.18.3"
global_version: "6.6.8"
```

### Step2. Make A Playbook

* Make My Unique Environment
    * You have `make_my_env`

* Make Your Unique Environment
    * You have `tasks/*.yml`

```
$ cp -a make_my_env make_your_env
$ vim make_your_env
```

OR

```
$ cp -a make_my_env_1.yml make_your_env.yml
$ vim make_your_env.yml
```

**(tasks)**

* apt_update_upgrade.yml
    * apt-update, apt-upgrade
* apt.yml
    * apt-install my-favorite-packages
* make_bashrc.yml
    * make my unique bashrc
* install_pip.yml
    * install pip
* install_pyenv.yml
    * install pyenv
* install_pyenv_versions.yml
    * install python2 and python3 for pyenv
* install_pipenv.yml
    * install pipenv
* install_golang.yml
    * install latest golang
* install_rust.yml
    * install rust
* install_neovim.yml
    * install neovim and make my unique init.vim
* install_rusgit.yml
    * install https://github.com/miyase256/rusgit
* install_exa.yml
    * install https://github.com/ogham/exa
* make_directories.yml
    * make my unique directories
* remake_bash_files.yml
    * remake bash files
* remake_neovim_files.yml
    * remake neovim files
* copy_sudoers.yml
    * copy my unique sudoers
* install_ffmpeg.yml
    * install ffmpeg

### Step3. Prepare password-file

```
$ vim /path/to/.sudo_password.txt
$ vim /path/to/.vault_password.txt
```

file name is any name.
vault password is any password for ansible-vault.

### Step4. initialize ansible-vault

```
$ ./chikuwansible-vault init /path/to/.sudo_password.txt /path/to/.vault_password.txt
$ rm -rf .sudo_password.txt
```

### Step5. Run Ansible-Playbook

```
$ sudo ./make_my_env
```

OR

```
$ sudo ./make_your_env
```

OR

```
$ sudo ./chikuwansible-playbook hoge.yml # make_your_env.yml, etc
```

OR

```
$ sudo ./chikuwansible-task tasks/hoge.yml # tasks/install_rust.yml, etc
```

