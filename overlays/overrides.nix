# * Overlay that overrides existing packages.
inputs: _final: prev: {
  vlc = prev.vlc.override { ffmpeg_6 = prev.ffmpeg_4; };
  betaflight-configurator = prev.betaflight-configurator.override {
    inherit (inputs.nixpkgs-betaflight.legacyPackages.${prev.system}) nwjs;
  };
}
