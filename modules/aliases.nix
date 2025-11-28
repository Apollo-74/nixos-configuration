let
  cfgPath = "~/nixos-configuration";
in
{
  environment.shellAliases = {
    ip = "ip --color=auto";
    sctl = "systemctl";
    k = "kubecolor";
    sudo = "sudo "; # this will make sudo work with shell aliases/man alias

    # NixOS
    nboot = "nixos-rebuild boot --sudo --no-reexec --flake ${cfgPath}";
    nswitch = "nixos-rebuild switch --sudo --no-reexec --flake ${cfgPath}";
    ncheck = "nix flake check ${cfgPath}";
    nupdate = "nix flake update --commit-lock-file --flake ${cfgPath}";
    # TODO with nix 2.19, nlock is no longer needed to update inputs
    nlock = "nix flake lock --commit-lock-file ${cfgPath}";
    # https://github.com/NixOS/nix/issues/8508
    nclear = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old";
  };
}
