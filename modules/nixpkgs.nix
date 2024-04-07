{ inputs, ... }:
{
  nixpkgs = {
    overlays = [ inputs.self.overlays.default ];
  };
}
