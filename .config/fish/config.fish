set fish_plugins theme peco

function fish_user_key_bindings
  bind \cr 'peco_sync_select_history (commandline -b)'
end

function docker_login
  docker exec -it $argv[1] bash
end

# bind
bind \cd delete-char

# alias
alias g git
alias docker-login docker_login
if type gsed > /dev/null 2>&1
  alias sed gsed
end
alias noti terminal-notifier

# env
set -x EDITOR vim
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# rbenv
rbenv init - | source

# Sync history
function history-merge --on-event fish_preexec
    history --save
    history --merge
end

function peco_sync_select_history
    history-merge
    peco_select_history $argv
end
