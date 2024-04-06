{ lib, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = lib.mkDefault [ "modesetting" ];
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
