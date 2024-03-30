pkgs: with pkgs; {
  sf = writeShellApplication {
    name = "sf";
    runtimeInputs = [
      curl
      wl-clipboard
    ];
    text = lib.readFile ./sf;
  };
}
