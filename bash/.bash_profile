# Client-specific aliases
alias mysql_ohd='mysql --login-path=onsitehd gibson_dev'

export VISUAL='vim'
export EDITOR='vim'
export CLICOLOR=true
export HISTCONTROL=ignoreboth
export SCREENDIR="/tmp/.screen-${USER}"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-12.jdk/Contents/Home"

if [ -n "$SCREENPWD" ]; then cd $SCREENPWD; fi
if [ -f ~/bin/ssh_completion ]; then . ~/bin/ssh_completion; fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then . $(brew --prefix)/etc/bash_completion; fi
if [ -f ~/bin/git-completion.bash ]; then . ~/bin/git-completion.bash; fi

[ -f "$HOME/.custom_prompt" ] && source "$HOME/.custom_prompt"

nowstamp() {
  date +'%Y%m%d%H%M%S'
}

[ -e ~/.bashrc ] && . ~/.bashrc
[ -e ~/.bash_aliases ] && . ~/.bash_aliases
