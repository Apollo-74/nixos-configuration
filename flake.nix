{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-betaflight.url = "github:nixos/nixpkgs/c9223ea44c223379f22a091c57700fa378a758df";

    flake-registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixos-ez-flake.url = "github:name-snrl/nixos-ez-flake/fb7fa79ecd4cd345d2a8c7a85e566f672b34e219";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixos-ez-flake, flake-parts, ... }:
    (flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./hosts
        ./overlays
        ./pkgs
        ./shell.nix
      ];
    })
    // {
      # Filesystem-based attribute set of module paths
      nixosModules = nixos-ez-flake.mkModuleTree ./modules;
    };
}
