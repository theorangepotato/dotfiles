#!/bin/fish

if test -e ~/.aliases
  source ~/.aliases
end

if test -e ~/.aliases_work
  source ~/.aliases_work
end

if test -e ~/.fish_funcs_work.fish
  source ~/.fish_funcs_work.fish
end

fish_vi_key_bindings

if type -q nvim
    set -gx EDITOR nvim
end

if type -q direnv
    direnv hook fish | source
end

set new_paths /var/lib/flatpak/exports/share /var/lib/flatpak/exports/bin $HOME/.local/share/flatpak/exports/share $HOME/.config/guix/current/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/bin

for i in $new_paths
    if not contains $i $PATH
        and test -d $i
        set PATH $i $PATH
    end
end
