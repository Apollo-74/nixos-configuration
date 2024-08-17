{ pkgs, config, ... }:
{
  programs = {
    firefox.enable = true;
    steam.enable = true;
    direnv.enable = true;
    htop.enable = true;
    traceroute.enable = true;
    nano.enable = false;
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
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  environment.systemPackages = with pkgs; [
    fd
    ripgrep
    eza
    wget
    tldr
    pciutils
    usbutils
    starship
    python3
    vscode
    scripts.sf
    alacritty
    gparted
    lact
    kdePackages.kcalc
    kdePackages.kdenlive
    kdePackages.ksvg
    jetbrains.pycharm-community
    fastfetch
    vlc
    mtr-gui
    chromium
    super-slicer-beta
    libreoffice-fresh
    tree
    telegram-desktop
    betaflight-configurator
    anydesk
    kdiskmark
    qbittorrent
    wireguard-tools
    dig
    docker
    libgcc
  ];

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.docker.enable = true;
}
