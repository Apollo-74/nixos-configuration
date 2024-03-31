{ pkgs, config, ... }:
{
  programs = {
    firefox.enable = true;
    steam.enable = true;
    direnv.enable = true;
    htop.enable = true;
    git = {
      enable = true;
      config = {
        user = {
          inherit (config.users.users.default) name;
          email = "Apollo-74@ya.ru";
        };

        url = {
          "git@github.com:".pushInsteadOf = "https://github.com/";
          "git@gist.github.com:".pushInsteadOf = "https://gist.github.com/";
        };
        commit.verbose = true;
      };
    };
    nix-index = {
      enable = true;
      package = pkgs.nix-index-with-db;
    };
    command-not-found.enable = false;
  };

  environment.systemPackages = with pkgs; [
    scripts.sf
    alacritty
    jetbrains.pycharm-community
    fastfetch
    vlc
    #super-slicer-beta
    libreoffice-fresh
    tree
    telegram-desktop
    betaflight-configurator
  ];
}
