{ pkgs, ... }:

{
  imports = [
    ./gui/kitty.nix
    ./gui/i3.nix
    # ./gui/dunst.nix
  ];

  home.username = "luki";
  home.homeDirectory = "/home/luki";
  home.stateVersion = "21.05";

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName  = "LuKi / Leonardo";
    userEmail = "leo.monteiro06@live.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      user.signingkey = "F0258C27407E9095";
      commit.gpgsign = "true";
      core.editor = "emacs";
    };
  };

}
