{ inputs, importsFromAttrs, ... }:
{
  imports = [
    ./hw-config.nix
  ]
  ++ importsFromAttrs {
    importByDefault = true;
    modules = inputs.self.nixosModules;
    imports = {
      servers.openssh = true;
    };
  };

  system.stateVersion = "24.05";
}
