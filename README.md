# Dot files

These files make your linux experience memorable.

## Pre-Requisits

- make sure you are in a linux os.
- you should have git installed on your machine
- please download the required software manually untill further commmit that addresses auto download.

## Steps to replicate installation : 

- clone this repository into your home folder
  - using https :
    ```bash
    cd
    git clone -b master https://github.com/HrishikeshMRao/.dotfiles
    ```  
  or  
  - using ssh :
    ```bash
    cd
    git clone -b master git@github.com:HrishikeshMRao/.dotfiles.git
    ```
- make sure to create the symbolic links manually (not recommended)
  or
- download stow using your favourite package manager

  ### Ubuntu
  - non root user:
  ```bash
  sudo apt install stow
  ```
  - super user:
  ```bash
  apt install stow
  ```
- run this command below and your are good to go:
  ```bash
  stow .
  ```
  This is stow magic

- reboot your system to make a fresh start to your exiting journey with linux ricing:
  
  - non root user:
  ```bash
  sudo reboot
  ```
  - super user:
  ```bash
  reboot
  ```
  
