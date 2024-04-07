# * Overlay that overrides existing packages.
_inputs: _final: prev: { vlc = prev.vlc.override { ffmpeg = prev.ffmpeg_4; }; }
