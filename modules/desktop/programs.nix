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
    ripgrep
    eza
    wget
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
    jetbrains.pycharm-community
    fastfetch
    mpv
    vlc
    super-slicer-beta
    libreoffice-fresh
    tree
    telegram-desktop
    betaflight-configurator
    anydesk
    kdiskmark
    qbittorrent
    gyroflow
    qemu_kvm
    virt-manager
  ];

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    onShutdown = "shutdown";
    qemu.package = pkgs.qemu_kvm;
    qemu.ovmf.packages = [
      (pkgs.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd
    ];
  };
}
