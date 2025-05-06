# .bashrc
 
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
 
alias ls='ls --color=auto'
alias la='ls --color=auto -a'
PS1='[\u@\h \W]\$ '
export TERM=xterm-256color

