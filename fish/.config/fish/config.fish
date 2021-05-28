#!/bin/fish

if test -e ~/.aliases
  cat ~/.aliases | source
end

if test -e ~/.aliases_work
  cat ~/.aliases_work | source
end
