{ pkgs, ... }:

{
  home = {
    file.".config/dunst/dunstrc" = ''
    '';
  };
}
