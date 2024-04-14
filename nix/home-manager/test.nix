{ config, pkgs, ... }:

let

new_cbonsai = pkgs.callPackage pkgs.cbonsai.override {
      version = "1.3.1";
      src = pkgs.fetchFromGitLab {
        owner = "jallbrit";
        repo = pkgs.cbonsai.pname;
        rev = "v${new_cbonsai.version}";
        sha256 = "sha256-kofJqMoBsvHrV3XfIQbSYO7OWpN7UgvrSs3WX3IVAJs=";
      };
    } { };
in
{
  home.packages = with pkgs; [
    bsdgames
    delta
    new_cbonsai
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  # Ensure all Nix manpages are accessible to system's man
  # Then disable Home Manager's version of man
  home.extraOutputsToInstall = [ "man" ];
  programs.man.enable = false;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "austin";
  home.homeDirectory = "/home/austin";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
