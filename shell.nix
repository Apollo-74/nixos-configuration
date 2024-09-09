{ inputs, ... }:
{
  imports = with inputs; [
    pre-commit-hooks-nix.flakeModule
    treefmt-nix.flakeModule
  ];
  perSystem =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShellNoCC { shellHook = config.pre-commit.installationScript; };

      pre-commit.settings.hooks = {
        treefmt = {
          enable = true;
          package = config.treefmt.build.wrapper;
        };
        statix = {
          enable = true; # check. not everything can be fixed, but we need to know what
          settings.format = "stderr";
        };
      };

      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
          deadnix.enable = true;
          statix.enable = true; # fix, if possible
          shellcheck.enable = true;
          shfmt = {
            enable = true;
            indent_size = 4;
          };
          mdformat.enable = true;
          mdformat.package = pkgs.mdformat.withPlugins (
            p: with p; [
              mdformat-gfm
              mdformat-frontmatter
              mdformat-footnote
            ]
          );
        };
        settings.formatter = {
          shfmt = {
            excludes = [ "*.nix" ];
            options = [ "--case-indent" ];
          };
          shellcheck = {
            excludes = [ "*.envrc" ];
          };
          mdformat.options = [
            "--wrap"
            "80"
          ];
        };
      };
    };
}
