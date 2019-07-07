if ! egrep -q "(^|:)/usr/local/sbin($|:)" <<< "$PATH"; then
  export PATH=/usr/local/sbin:$PATH
fi
if ! egrep -q "(^|:)/usr/local/bin($|:)" <<< "$PATH"; then
  export PATH=/usr/local/bin:$PATH
fi
if ! egrep -q "(^|:)$HOME/bin($|:)" <<< "$PATH"; then
  export PATH=$HOME/bin:$PATH
fi
if [ -d /opt/metasploit-framework/bin ] && ! egrep -q "(^|:)/opt/metasploit-framework/bin($|:)" <<< "$PATH"; then
  export PATH=$PATH:/opt/metasploit-framework/bin
fi

if type -t rbenv >/dev/null; then
  if [ -d /usr/local/var/rbenv ]; then
    export RBENV_ROOT=/usr/local/var/rbenv
  fi
  eval "$(rbenv init - --no-rehash)"
fi

[ -f "$HOME/bin/find_ssh_agent" ] && source "$HOME/bin/find_ssh_agent"

