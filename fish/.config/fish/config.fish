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
