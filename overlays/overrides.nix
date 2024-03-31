# Overlay that overrides existing packages.
inputs: final: _prev: {
  inherit (inputs.nixpkgs-slicer.legacyPackages.${final.system}) super-slicer-beta;
}
