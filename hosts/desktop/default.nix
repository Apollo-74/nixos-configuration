{
  inputs,
  importsFromAttrs,
  pkgs,
  lib,
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
  hardware.opengl = {
    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  hardware.opengl.extraPackages =
    if pkgs ? rocmPackages.clr then
      with pkgs.rocmPackages;
      [
        clr
        clr.icd
        pkgs.amdvlk
      ]
    else
      with pkgs;
      [
        rocm-opencl-icd
        rocm-opencl-runtime
        pkgs.amdvlk
      ];

  system.stateVersion = "24.05";
}
