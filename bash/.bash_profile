# Client-specific aliases
alias mysql_ohd='mysql --login-path=onsitehd gibson_dev'

export VISUAL='vim'
export EDITOR='vim'
export CLICOLOR=true
export HISTCONTROL=ignoreboth
export PATH=$HOME/bin:/usr/local/heroku/bin:$PATH
export SCREENDIR="/tmp/.screen-${USER}"

if [ -n "$SCREENPWD" ]; then cd $SCREENPWD; fi
if [ -f ~/bin/ssh_completion ]; then . ~/bin/ssh_completion; fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then . $(brew --prefix)/etc/bash_completion; fi
if [ -f ~/bin/git-completion.bash ]; then . ~/bin/git-completion.bash; fi

[ -f "$HOME/.custom_prompt" ] && source "$HOME/.custom_prompt"

quit() {
  osascript -e "tell app \"$1\" to quit"
}

nowstamp() {
  date +'%Y%m%d%H%M%S'
}

[ -e ~/.bashrc ] && . ~/.bashrc
[ -e ~/.bash_aliases ] && . ~/.bash_aliases
