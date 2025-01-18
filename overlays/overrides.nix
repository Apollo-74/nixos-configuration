# * Overlay that overrides existing packages.
inputs: _final: prev: {
  vlc = prev.vlc.override { inherit (prev) ffmpeg_4; };
  betaflight-configurator = prev.betaflight-configurator.override {
    inherit (inputs.nixpkgs-betaflight.legacyPackages.${prev.system}) nwjs;
  };
  inherit
    (import inputs.nixpkgs-anydesk {
      inherit (prev) system;
      config.allowUnfree = true;
    })
    anydesk
    ;
}
