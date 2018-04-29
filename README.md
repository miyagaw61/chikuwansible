# chikuwansible - my unique ubuntu environment maker

* This can make my unique ubuntu environment.
* Your using one task-file of this repository enable installing any program.

## Usage

### Step1. Install Ansible

[READ HERE](https://qiita.com/miyagaw61/private/ca7eda54bbab392a8b78)

### Step2. Edit "vars/editable.yml"

* "vars/editable.yml" is a file defining variables.
* You may have to edit this accordingly.

```
cd chikuwansible.git
vim vars/editable.yml
```

### Step3. Make A Playbook

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
