{ pkgs, ... }:

{
  imports = [
    ./gui/kitty.nix
  ];

  home.username = "luki";
  home.homeDirectory = "/home/luki";
  home.stateVersion = "23.05";

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "instance" = {
        hostname = "193.123.121.240";
        user = "luki";
      };
    };
  };

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
      core.pager = "diff-so-fancy | /run/current-system/sw/bin/less --tabs=4 -RFX";
      interactive.diffFilter = "diff-so-fancy --patch";
    };
  };
}
