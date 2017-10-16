set fish_plugins theme peco

function fish_user_key_bindings
  bind \cr peco_select_history
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
alias owata 'terminal-notifier -message "owata"'

# env
set EDITOR vim
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
