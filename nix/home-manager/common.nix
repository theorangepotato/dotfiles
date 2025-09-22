{ config, pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # nix
    npins
    comma
    # base
    stow
    man
    ripgrep
    fd
    fzf
    # exa
    bat
    openssh
    which
    ncdu
    sysstat
    bottom
    unzip

    # productivity
    git
    zellij

    # fun
    cbonsai
    fortune

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Alternative import of the fish config file
  # programs.fish.shellInit = (builtins.readFile ../../../fish/.config/fish/config.fish);
  # programs.fish.interactiveShellInit = "set -g fish_greeting";

  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.concatStringsSep "\n" [
      (builtins.readFile ../../generic/.aliases)
      "fish_vi_key_bindings"
      "set -g fish_greeting"
      "${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source"
    ];
  };
  programs.fzf.enableFishIntegration = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set linebreak
      set showbreak=+++
      set showmatch
      syntax on

      set hlsearch
      set smartcase
      set ignorecase
      set incsearch

      set autoindent
      set shiftwidth=4
      " set smartindent

      set ruler

      set undolevels=1000
      set backspace=indent,eol,start

      " make Y consistent with C and D.
      nnoremap Y y$
    '';
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Austin Bohannon";
        email = "github@alphahotelbravo.io";
      };
      ui = {
        default-command = "log";
      };
      diff.color-words.conflict = "pair";
    };
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/austin/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
}
