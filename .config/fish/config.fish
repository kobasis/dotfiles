if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# bind
bind -e \cd
bind \cd delete-char

# alias
if type gsed > /dev/null 2>&1
  blias sed gsed
end

# env
set -x EDITOR vim

# rbenv
rbenv init - | source
