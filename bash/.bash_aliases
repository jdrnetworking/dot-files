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
alias ras="bundle exec rails server -b localhost -p 3000"
alias be="bundle exec"
alias reload_dns="sudo discoveryutil udnsflushcaches"
alias datestamp='date +"%Y%m%d%H%M%S"'
alias recover_x11='wmctrl -e 0,120,90,1680,900 -r'
alias sum_lines="awk '{s+=\$1} END {print s}'"
alias edit_merge_conflicts='vi $(git st --porcelain | ack "^U" | field -1)'
alias bqr='brakeman -q --no-pager; rubocop'
