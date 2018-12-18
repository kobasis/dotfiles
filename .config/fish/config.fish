if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# bind
bind -e \cd
bind \cd delete-char

function fish_user_key_bindings
  # fzf
  bind \ef '__fzf_find_file'
  bind \cr '__fzf_reverse_isearch'
  bind \co '__fzf_open --editor'

  # ghq
  bind \cg '__ghq_crtl_g'
end

# alias
if type gsed > /dev/null 2>&1
  blias sed gsed
end

# env
set -x EDITOR vim

# rbenv
rbenv init - | source
