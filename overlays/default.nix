inputs: with inputs;
nixpkgs.lib.composeManyExtensions [
  self.overlays.basic
  self.overlays.scripts
  self.overlays.symlinks
  nvim.overlays.default
]
