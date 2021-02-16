# Aliases
alias upgr='sudo apt update; sudo apt -y upgrade && sudo apt -y autoremove; flatpak update -y; cargo install-update -ag; fwupdmgr update'
alias upgr4='sudo apt-get -o Acquire::ForceIPv4=true update && sudo apt-get -y -o Acquire::ForceIPv4=true upgrade && sudo apt-get -y -o Acquire::ForceIPv4=true autoremove'
alias inst='sudo apt -y install'
alias fd='fdfind'
alias dict='sdcv'
alias vi='nvim'
alias vim='nvim'
alias ls='exa'
alias ssh='kitty +kitten ssh'
alias vpn='sudo wg-quick up wg0'
alias vpnd='sudo wg-quick down wg0'
alias cat='bat'
alias less='bat --paging always'
alias clh='history -c && exit'

# Functions
function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}
