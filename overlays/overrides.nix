/*
 * Overlay that overrides existing packages.
 */
inputs: final: prev: {

  neovim-unwrapped = inputs.nvim-nightly.packages.${final.system}.neovim;

  # remove on release > 0.7.0
  xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs (oa: {
    __contentAddressed = true;
    patches = [
      (final.fetchpatch {
        url = "https://github.com/emersion/xdg-desktop-portal-wlr/pull/282.patch";
        hash = "sha256-HqmjS7APOeXhrhKdrzUGL8hLL6x5C8m5nvYP8O+jJFo=";
      })
    ];
  });

  foot = prev.foot.overrideAttrs (oa: {
    __contentAddressed = true;
    patches = [
      (final.fetchpatch {
        url = "https://codeberg.org/dnkl/foot/pulls/1099.patch";
        hash = "sha256-4B+PanJqBC3hANgSYXwXeGO19EBdVMyyIgGawpaIMxE=";
      })
    ];
    mesonFlags = oa.mesonFlags ++ [ "-Dext-underline=enabled" ];
  });

  gojq = with final; symlinkJoin {
    name = "gojq";
    paths = [ jq.man prev.gojq ];
    postBuild = "mv $out/bin/gojq $out/bin/jq";
  };

  xdragon = with final; let
    dg = writeShellApplication {
      name = "dg";
      runtimeInputs = [ prev.xdragon ];
      text = ''dragon -T "$@" &>/dev/null &'';
    };
  in
  symlinkJoin { name = "xdragon"; paths = [ prev.xdragon dg ]; };

  page = with final; let
    less = writeShellApplication {
      name = "less";
      runtimeInputs = [ prev.page ncurses ];
      text = ''exec page -O "$(tput lines)" "$@"'';
    };
  in
  symlinkJoin { name = "page"; paths = [ prev.page less ]; };

  swayimg = with final; let
    swim-wp = writeShellScriptBin "swim-wp" ''
      exec ${prev.swayimg}/bin/swayimg --fullscreen ${wallpapers}
    '';
    desktop = makeDesktopItem {
      desktopName = "Swayimg-wallpapers";
      name = "swim-wp";
      exec = "${swim-wp}/bin/swim-wp";
      categories = [ "Graphics" "Viewer" ];
      icon = "swayimg";
    };
    wallpapers = lib.concatStringsSep " "
      (lib.forEach
        (lib.importJSON ./wallhaven-collection.json)
        (data: (fetchurl data)));
  in
  symlinkJoin {
    name = "swayimg";
    paths = [ prev.swayimg swim-wp desktop ];
    postBuild = "ln -s $out/bin/swayimg $out/bin/swim";
  };

  graphite-gtk-theme = prev.graphite-gtk-theme.overrideAttrs (_: {
    __contentAddressed = true;

    version = "flake";
    src = inputs.graphite-gtk;

    installPhase = ''
      runHook preInstall

      patchShebangs install.sh
      name= ./install.sh \
        --size compact \
        --tweaks darker nord rimless \
        --dest $out/share/themes

      jdupes --quiet --link-soft --recurse $out/share

      runHook postInstall
    '';
  });

  graphite-kde-theme = prev.graphite-kde-theme.overrideAttrs (_: {
    __contentAddressed = true;

    version = "flake";
    src = inputs.graphite-kde;

    installPhase = ''
      runHook preInstall

      patchShebangs install.sh
      substituteInPlace install.sh \
        --replace '$HOME/.local' $out \
        --replace '$HOME/.config' $out/share
      name= ./install.sh --theme nord --rimless

      runHook postInstall
    '';
  });

}