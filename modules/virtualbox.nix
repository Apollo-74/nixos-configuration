_: {
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "apollo" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
}
