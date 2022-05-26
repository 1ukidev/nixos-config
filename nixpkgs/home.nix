{ pkgs, ... }:

{
  imports = [
    ./gui/kitty.nix
    ./gui/i3.nix
    # ./gui/dunst.nix
  ];

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
    };
  };
}
