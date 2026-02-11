# Dot files

These files make your linux experience memorable.

## Pre-Requisits

- make sure you are in a linux os.
- you should have git installed on your machine.

## Initial personel configurations

- execute the below block to launch mpd and setup software level keymaps (personel).
  ```bash
  cat << 'EOF' >> ~/.profile
  #!/bin/bash
  # execute keybinding if the display env variable is set
  
  if [ "$DISPLAY" ] ; then
     mpd &
     setxkbmap -option ctrl:nocaps
     xcape -e 'Control_L=Escape' -t 175
  fi
  ~/auto_keychain.expect
  EOF
  ```
  - **Do the following only if u want automatic passphrase setup for ssh.**
  - Remember to substitute your ssh passphrase in the place of \[\[YOUR_PASSPHRASE\]\]

  ```bash
  cat << 'EOF' >> ~/auto_keychain.expect
  #!/usr/bin/expect
  
  spawn keychain --eval --agents ssh /home/$env{USER}/.ssh/id_ed25519
  
  expect "Enter passphrase for* " { send "[[YOUR_PASSPHRASE]]\r" }
  
  interact
  EOF
  ```
  
- installed the required packages for the dotfiles to act on (non root user):
  ```bash
  sudo apt install neovim mpd i3-wm tmux picom rofi ncmpcpp fzf ripgrep keychain expect curl
  ```

  to install zoxide:
  ```bash
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
  ```

  install kitty with:
  ```bash
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  ```

## Steps to replicate installation :

- clone this repository into your home folder
  - using https :
    ```bash
    cd
    git clone -b master https://github.com/HrishikeshMRao/.dotfiles.git
    ```

  ### or

  - using ssh :
    ```bash
    cd
    git clone -b master git@github.com:HrishikeshMRao/.dotfiles.git
    ```
- Make sure to create the symbolic links manually (not recommended).

  ### or

  Download stow using your favourite package manager:

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
    cd ~/.dotfiles
    stow .
    ```
    This is stow magic.

- If you want to install my gnome-terminal profiles (recommended) run :
    ```bash
    dconf load /org/gnome/terminal/legacy/profiles:/ < ~/.dotfiles/gnome-terminal-profile.dconf
    ```

- reboot your system to make a fresh start to your exiting journey with linux ricing:

    - non root user:
    ```bash
    sudo reboot
    ```
    - super user:
    ```bash
    reboot
    ```

