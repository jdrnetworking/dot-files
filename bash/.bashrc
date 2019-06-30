export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
if type -t rbenv >/dev/null; then
  if [ -d /usr/local/var/rbenv ]; then
    export RBENV_ROOT=/usr/local/var/rbenv
  fi
  eval "$(rbenv init - --no-rehash)"
fi

[ -f "$HOME/bin/find_ssh_agent" ] && source "$HOME/bin/find_ssh_agent"

