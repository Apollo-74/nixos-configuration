{ pkgs, ... }:
{
  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.systemd.enable = true;
    supportedFilesystems = [ "ntfs" ];
    tmp.useTmpfs = true;
    tmp.tmpfsSize = "80%";

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
