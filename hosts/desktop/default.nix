{ inputs, importsFromAttrs, ... }:
{
  imports =
    [ ./hw-config.nix ]
    ++ importsFromAttrs {
      importByDefault = true;
      modules = inputs.self.nixosModules;
      imports = {
        servers.openssh = true;
      };
    };

  # Firmware
  #services.fwupd.enable = true; # https://fwupd.org/lvfs/devices/

  # CPU
  #powerManagement.cpuFreqGovernor = "schedutil";

  # GPU acceleration

  system.stateVersion = "24.05";
}
