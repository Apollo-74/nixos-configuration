{
    programs = {
    firefox.enable = true;
    steam.enable = true;
        direnv.enable = true;
    nix-index = {
      enable = true;
      package = pkgs.nix-index-with-db;
    };
    command-not-found.enable = false;

  };

  environment.systemPackages = with pkgs; [
    alacritty
  ];
}