{ lib, inputs, ... }:
{
  flake.overlays = {
    default =
      with inputs;
      lib.composeManyExtensions [
        self.overlays.overrides
        self.overlays.gateway
        self.overlays.pkgs
      ];
    overrides = import ./overrides.nix inputs;
    gateway = import ./gateway.nix inputs;
  };
}
