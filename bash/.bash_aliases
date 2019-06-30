alias ll='ls -l'
alias df='df -h'
alias du='du -h'
alias g='git'
alias beep='tput bel'
alias rscp='rsync -avzP -e ssh'
alias ras="bundle exec rails server -b localhost -p 3000"
alias be="bundle exec"
alias datestamp='date +"%Y%m%d%H%M%S"'
alias sum_lines="awk '{s+=\$1} END {print s}'"
alias edit_merge_conflicts='vi $(git st --porcelain | ack "^U" | field -1)'
alias bqr='brakeman -q --no-pager; rubocop'
alias vi=vim

if [ "$(uname -s)" = "Darwin" ]; then
  alias md5sum='md5 -r'
  alias reload_dns="sudo discoveryutil udnsflushcaches"
  alias recover_x11='wmctrl -e 0,120,90,1680,900 -r'
  alias terminal_copy_plain="defaults write com.apple.Terminal CopyAttributesProfile com.apple.Terminal.no-attributes"
  alias terminal_copy_rich="defaults write com.apple.Terminal CopyAttributesProfile com.apple.Terminal.attributes"
  alias mute="/usr/bin/osascript -e 'set volume output muted 1'"
  alias unmute="/usr/bin/osascript -e 'set volume output muted 0'"
fi

if type -t xclip >/dev/null; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi
