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

set new_paths /var/lib/flatpak/exports/bin $HOME/.config/guix/current/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/bin
 
for i in $new_paths
    if not contains $i $PATH
        set PATH $i $PATH
    end
end

set -gx EDITOR nvim

direnv hook fish | source
