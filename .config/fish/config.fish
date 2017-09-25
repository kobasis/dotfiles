set fish_plugins theme peco

function fish_user_key_bindings
  bind \cr peco_select_history # Bind for prco history to Ctrl+r
end

function docker_login
  docker exec -it $argv[1] bash
end

# alias
alias g git
alias docker-login docker_login
if type gsed > /dev/null 2>&1
  alias sed gsed
end

# env
set EDITOR vim
