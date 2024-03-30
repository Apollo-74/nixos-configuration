{
  pkgs,
  inputs,
  importsFromAttrs,
  ...
}:
{
  imports =
    [ ./hw-config.nix ]
    ++ importsFromAttrs {
      importByDefault = true;
      modules = inputs.self.nixosModules;
      imports = {
        profiles.system.servers.openssh = false;
        profiles.system.desktop.work = false;
      };
    };

  # Firmware
  #services.fwupd.enable = true; # https://fwupd.org/lvfs/devices/

  # CPU
  #powerManagement.cpuFreqGovernor = "schedutil";

  # GPU acceleration
  #hardware.opengl.extraPackages = with pkgs; [ intel-media-driver ];

  system.stateVersion = "24.05";
}
