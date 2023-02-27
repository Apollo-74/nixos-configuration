inputs: with inputs.nixpkgs.lib;
rec {
  forAllSystems = genAttrs systems.flakeExposed;

  pkgsFor = system: import inputs.nixpkgs {
    overlays = [ inputs.self.overlay ];
    localSystem = { inherit system; };
    config = {
      allowUnfree = true;
      joypixels.acceptLicense = true;
    };
  };

  mkAttrsTree = dir:
    mapAttrs'
      (name: type:
        if type == "directory"
        then nameValuePair name (mkAttrsTree /${dir}/${name})
        else nameValuePair (removeSuffix ".nix" name) /${dir}/${name})
      (filterAttrs
        (name: type:
          type == "directory" || hasSuffix ".nix" name)
        (builtins.readDir dir));

  mkModules = dir:
    let
      listOfPaths = dir: flatten (mapAttrsToList
        (name: type:
          if type == "directory"
          then [ /${dir}/${name + "Tree"} (listOfPaths /${dir}/${name}) ]
          else /${dir}/${name})
        (filterAttrs
          (name: type:
            type == "directory" || hasSuffix ".nix" name)
          (builtins.readDir dir)));
    in
    listToAttrs
      (forEach (listOfPaths dir)
        (path:
          if ! hasSuffix "Tree" (baseNameOf path) then
            if baseNameOf path == "default.nix"
            then nameValuePair (baseNameOf (dirOf path)) path
            else nameValuePair (removeSuffix ".nix" (baseNameOf path)) path
          else
            nameValuePair
              (baseNameOf path)
              (mkAttrsTree /${dirOf path}/${removeSuffix "Tree" (baseNameOf path)})
        ));

  attrsFromHosts = dir: genAttrs (builtins.attrNames (builtins.readDir dir));

  mkHosts = dir: (attrsFromHosts dir)
    (name:
      nixosSystem {
        system = "x86_64-linux";
        pkgs = pkgsFor "x86_64-linux";
        specialArgs = { inherit inputs; inherit (inputs.self) nixosModules; };
        modules = [ /${dir}/${name} { networking.hostName = name; } ] ++
          filter (val: isPath val) (attrValues inputs.self.nixosModules);
      });

  hostsAsPkgs = cfgs:
    foldAttrs (x: y: x // y) { }
      (concatLists
        (forEach (attrNames cfgs)
          (name:
            with cfgs.${name}.config.system;
            with cfgs.${name}.pkgs;
            if name == "liveCD"
            then [{ ${system}.${name} = build.isoImage; }]
            else [{ ${system}.${name} = build.toplevel; }])
        )
      );
}