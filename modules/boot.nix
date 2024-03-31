{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.systemd.enable = true;
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
