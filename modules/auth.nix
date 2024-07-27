{
  users.users = {
    default = {
      name = "apollo";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "dialout"
        "video"
        "kvm"
        "networkmanager"
        "lxd"
        "libvirtd"
        "vboxusers"
        "docker"
      ];
    };
  };
}
