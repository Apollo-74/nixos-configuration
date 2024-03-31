{ pkgs, ... }:
{
  boot = {
    initrd.availableKernelModules = [
      "sd_mod"
      "ext4"
      "amdgpu"
    ];
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.systemd.enable = true;
    initrd.includeDefaultModules = false;
    supportedFilesystems = [ "ntfs" ];
    tmp.useTmpfs = true;

    loader = {
      efi.canTouchEfiVariables = false;
      timeout = 3;
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
        consoleMode = "max";
      };
    };
  };
}
