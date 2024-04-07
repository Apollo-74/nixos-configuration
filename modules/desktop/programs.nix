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
    fd
    eza
    wget
    python3
    vscode
    scripts.sf
    alacritty
    gparted
    yandex-browser
    kdePackages.kcalc
    jetbrains.pycharm-community
    fastfetch
    vlc
    mpv
    super-slicer-beta
    libreoffice-fresh
    tree
    telegram-desktop
    betaflight-configurator
    anydesk
    kdiskmark
    qbittorrent
    gyroflow
  ];
}
