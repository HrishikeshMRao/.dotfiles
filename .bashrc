
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE= HISTFILESIZE= #Infinite

set -o vi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f "$HOME/.config/aliasrc" ]&& source "$HOME/.config/aliasrc"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


bind -f ~/.dotfiles/.inputrc

bind "set show-all-if-ambiguous on"
bind 'TAB: menu-complete'
bind '"\C-j": history-search-backward'
bind '"\C-k": history-search-forward'
bind "set menu-complete-display-prefix on"

# colored GCC warnings and errors
export LS_COLORS='di=38;5;122:ow=38;5;122:tw=38;5;122:fi=38;5;210:ln=38;5;210:pi=38;5;210:so=38;5;210:bd=38;5;210:cd=38;5;210:or=38;5;210:mi=38;5;210:ex=38;5;74:*.zip=4;223:*.txt=38;5;223'
export GCC_COLORS='error= 38;5;211:warning=38;5;223:note=38;5;159:caret=38;5;183:locus=38;5;183:quote=38;5;183'
export PS1="\n\[\033[38;5;175m\]\u \[\033[38;5;180m\]\w\n\[\033[38;5;74m\]\$(echo \h | cut -d'-' -f1,2) \\[\033[38;5;183m\]\$ \[\033[38;5;252m\]"

source /opt/ros/humble/setup.bash
# source /usr/share/gazebo/setup.sh
#source ~/Navigation_Bot/dev_ws/install/setup.bash
# source ~/voice_grab/ros2_ws/install/setup.bash
# source ~/ws_moveit/install/setup.bash

man() {
  /usr/bin/man "$@" | \
    col -b | \
    nvim -R -c 'set ft=man nomod nolist' -
}

# Force ncmpcpp to use sane bindings
alias ncmpcpp='ncmpcpp -b .config/ncmpcpp/bindings'
alias fman="manpath | \
    tr ':' '\n' | \
    xargs -I {} find {} -type f | \
    grep '/man[1-9]/' | \
    sed 's#.*/man[1-9]/\(.*\)\.[1-9].*#\1#' | \
    sort -u | \
    fzf --preview 'man -P cat {}' | \
    xargs -r -I {} sh -c 'man {} | col -b | nvim -R -c \"set ft=man nomod nolist\" -'
"
alias fsize='du -ah . | sort -hr | head -n 10'
alias rpush='rsync -a /home/fiend/Desktop/Rpi/ pi@fiendpi.local:/home/pi/Rpi/'
alias rpull='rsync -a pi@fiendpi.local:/home/pi/Rpi/ /home/fiend/Desktop/Rpi/'

# Check if tmux is already running
if  [ -z "$TMUX" ]; then
    tmux attach
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
eval "$(zoxide init --cmd cd bash)"
eval $(keychain --eval --agents ssh ~/.ssh/id_ed25519 > /dev/null 2>&1)



