alias mute="/usr/bin/osascript -e 'set volume output muted 1'"
alias unmute="/usr/bin/osascript -e 'set volume output muted 0'"
alias ll='ls -l'
alias df='df -h'
alias du='du -h'
alias g='git'
alias md5sum='md5 -r'
alias beep='tput bel'
alias cdocs='/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt -t --mount /Users/jon/Dropbox/cdocs /Volumes/CDOCS'
alias rscp='rsync -avzP -e ssh'
alias ras="authbind rails s -p 80"

# Client-specific aliases
alias mysql_ohd='mysql --defaults-group-suffix=ohd'


if [ -n "$SCREENPWD" ]; then cd $SCREENPWD; fi
if [ -f ~/bin/ssh_completion ]; then . ~/bin/ssh_completion; fi
if [ -f ~/bin/git-completion.bash ]; then . ~/bin/git-completion.bash; fi
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi
export VISUAL='vim'
export EDITOR='vim'
export CLICOLOR=true
export MANPATH=$MANPATH:/opt/local/share/man
export HISTCONTROL=ignoreboth
export PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/heroku/bin:$PATH:$HOME/android-sdk/platform-tools:/opt/local/lib/mysql55/bin:$HOME/.rvm/bin:$HOME/Code/php/arcanist/arcanist/bin:$HOME/Code/elixir/elixir/bin
export CC="gcc-apple-4.2"
[ -f "$HOME/.custom_prompt" ] && source "$HOME/.custom_prompt"

[ -f "$HOME/bin/find_ssh_agent" ] && source "$HOME/bin/find_ssh_agent"

quit() {
  osascript -e "tell app \"$1\" to quit"
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

autotest() { [ -f Gemfile.local ] && BUNDLE_GEMFILE=Gemfile.local `which autotest` $* || `which autotest` $*; }
export -f autotest

nowstamp() { date +'%Y%m%d%H%M%S'; }
