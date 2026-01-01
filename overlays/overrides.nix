# * Overlay that overrides existing packages.
_inputs: _final: prev: {
  vlc = prev.vlc.override { inherit (prev) ffmpeg_7; };
}
