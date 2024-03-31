{
  inputs,
  importsFromAttrs,
  pkgs,
  ...
}:
{
  imports =
    [ ./hw-config.nix ]
    ++ importsFromAttrs {
      importByDefault = true;
      modules = inputs.self.nixosModules;
      imports = {
        servers.openssh = false;
      };
    };

  # Firmware
  #services.fwupd.enable = true; # https://fwupd.org/lvfs/devices/

  # CPU
  #powerManagement.cpuFreqGovernor = "schedutil";

  # GPU acceleration
  hardware.opengl.extraPackages = [ pkgs.amdvlk ];

  system.stateVersion = "24.05";
}
