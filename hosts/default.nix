{ lib, inputs, ... }:
with inputs;
{
  flake = {
    nixosConfigurations = lib.mapAttrs (
      hostName: modules:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit (inputs.nixos-ez-flake) importsFromAttrs;
        };
        modules = [
          {
            networking = {
              inherit hostName;
            };
          }
        ]
        ++ inputs.nixos-ez-flake.importsFromAttrs { inherit modules; };
      }
    ) (lib.removeAttrs (inputs.nixos-ez-flake.mkModuleTree ./.) [ "self" ]);
    packages =
      with lib;
      let
        cfgs = inputs.self.nixosConfigurations;
      in
      foldAttrs (x: y: x // y) { } (
        concatLists (
          forEach (attrNames cfgs) (
            name:
            with cfgs.${name};
            if name == "liveCD" then
              [ { ${pkgs.system}.${name} = config.system.build.isoImage; } ]
            else
              [ { ${pkgs.system}.${name} = config.system.build.toplevel; } ]
          )
        )
      );
  };
}
