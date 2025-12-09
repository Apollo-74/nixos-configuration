{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs = {
    firefox.enable = true;
    steam.enable = true;
    direnv.enable = true;
    htop.enable = true;
    traceroute.enable = true;
    nano.enable = false;
    foot.enable = false;
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
    throne = {
      enable = true;
      tunMode.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    fd
    ripgrep
    eza
    wget
    tldr
    pciutils
    usbutils
    python3
    vscode
    scripts.sf
    gparted
    gsmartcontrol
    lact
    kdePackages.kcalc
    kdePackages.kdenlive
    kdePackages.ksvg
    jetbrains.pycharm-professional
    jetbrains.goland
    nerd-fonts.jetbrains-mono
    go
    fastfetch
    mpv
    mpvScripts.uosc
    mtr-gui
    chromium
    super-slicer-beta
    libreoffice
    tree
    telegram-desktop
    betaflight-configurator
    anydesk
    kdiskmark
    qbittorrent
    dig
    docker
    libgcc
    gcc
    kubectl
    kubecolor
    remmina
    zellij
    strongswan
    kubernetes-helm
    uv
    btop
    bat
    k9s
    networkmanager-strongswan
    zed-editor
    sshfs
    talosctl
    foot
  ];

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.docker.enable = true;

  services.tailscale.enable = true;
  services.strongswan.enable = true;
  systemd.services.strongswan.environment.STRONGSWAN_CONF =
    lib.mkForce "/home/apollo/ipsec/strongswan.conf";
  services.strongswan.secrets = [ "/etc/ipsec-foo.secret" ];
}
