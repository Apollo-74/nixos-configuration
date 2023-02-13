{ pkgs, inputs, ... }: {
  imports = [
    ./hw-config.nix
    inputs.self.nixosRoles.desktop
  ];

  boot.initrd.kernelModules = [ "i915" ]; # Enable early KMS

  # Firmware
  #services.fwupd.enable = true; # https://fwupd.org/lvfs/devices/

  # CPU
  powerManagement.cpuFreqGovernor = "schedutil";

  # GPU acceleration
  environment.sessionVariables.LIBVA_DRIVER_NAME = "i965";
  hardware.opengl.extraPackages = with pkgs; [ beignet vaapiIntel ];

  system.stateVersion = "22.05";
}
