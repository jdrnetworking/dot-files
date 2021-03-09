export VISUAL='vim'
export EDITOR='vim'
export CLICOLOR=true
export SCREENDIR="/tmp/.screen-${USER}"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-12.jdk/Contents/Home"
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export HISTCONTROL=ignoreboth
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize

if [ -n "$SCREENPWD" ]; then cd $SCREENPWD; fi
if [ -f ~/bin/ssh_completion ]; then . ~/bin/ssh_completion; fi
if ! shopt -oq posix; then
  if type -t brew >/dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
if [ -f ~/bin/git-completion.bash ]; then . ~/bin/git-completion.bash; fi
if [ -f ~/bin/newchrome ]; then . ~/bin/newchrome; fi
if type heroku >/dev/null 2>&1; then
  HEROKU_AC_BASH_SETUP_PATH=/Users/jriddle/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH
fi

if [ "$(uname -s)" = "Darwin" ]; then
  [ -f "$HOME/.custom_prompt" ] && source "$HOME/.custom_prompt"
  export BASH_SILENCE_DEPRECATION_WARNING=1
elif [ "$(uname -s)" = "Linux" ]; then
  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi
  if [ "$CLICOLOR" = "true" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

nowstamp() {
  date +'%Y%m%d%H%M%S'
}

[ -e ~/.bashrc ] && . ~/.bashrc
[ -e ~/.bash_aliases ] && . ~/.bash_aliases
