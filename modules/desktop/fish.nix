{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.fish;
  programs.fish = {
    enable = true;
    interactiveShellInit = with pkgs; ''
      set -U fish_greeting # disable greeting
    '';
  };
}
