export PATH=$HOME/bin:$PATH
export RBENV_ROOT=/usr/local/var/rbenv

[ -f "$HOME/bin/find_ssh_agent" ] && source "$HOME/bin/find_ssh_agent"

if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi
