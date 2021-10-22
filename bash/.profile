# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ] && [ -z "$BASHRC_LOADED" ] ; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH to include guix, if it exists
# old value: $HOME/.guix-profile/bin
if [ -d "$HOME/.config/guix/current/bin" ] ; then
    PATH="$HOME/.config/guix/current/bin${PATH:+:}$PATH"
fi

# set PATH to include flatpak, if it exists
if [ -d "/var/lib/flatpak/exports/bin" ] ; then
    PATH="/var/lib/flatpak/exports/bin:$PATH"
fi

# set PATH so it includes cargo's bin if it exists
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export EDITOR="nvim"
