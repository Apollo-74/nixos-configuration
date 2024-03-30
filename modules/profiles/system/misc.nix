{ config, lib, ... }:
{
  programs.adb.enable = true;
  users.users.default.extraGroups = [ "adbusers" ];

  services = {
    dbus.implementation = "broker";
    udisks2.enable = true;
  };
}
