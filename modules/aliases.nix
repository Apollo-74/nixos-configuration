let
  cfgPath = "~/nixos-configuration";
in
{
  environment.shellAliases = {
    ip = "ip --color=auto";
    sctl = "systemctl";
    sudo = "sudo "; # this will make sudo work with shell aliases/man alias
    wg0up = "sudo wg-quick up wg0";
    wg0down = "sudo wg-quick down wg0";
    wg1up = "sudo wg-quick up wg1";
    wg1down = "sudo wg-quick down wg1";

    # NixOS
    nboot = "nixos-rebuild boot --use-remote-sudo --fast --flake ${cfgPath}";
    nswitch = "nixos-rebuild switch --use-remote-sudo --fast --flake ${cfgPath}";
    ncheck = "nix flake check ${cfgPath}";
    nupdate = "nix flake update --commit-lock-file ${cfgPath}";
    # TODO with nix 2.19, nlock is no longer needed to update inputs
    nlock = "nix flake lock --commit-lock-file ${cfgPath}";
    # https://github.com/NixOS/nix/issues/8508
    nclear = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old";
  };
}
