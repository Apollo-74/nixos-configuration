# * Overlay that overrides existing packages.
inputs: _final: prev: {
  vlc = prev.vlc.override { inherit (prev) ffmpeg_7; };
  betaflight-configurator = prev.betaflight-configurator.override {
    inherit (inputs.nixpkgs-betaflight.legacyPackages.${prev.stdenv.hostPlatform.system}) nwjs;
  };
  inherit
    (import inputs.nixpkgs-anydesk {
      inherit (prev.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    })
    anydesk
    ;
}
