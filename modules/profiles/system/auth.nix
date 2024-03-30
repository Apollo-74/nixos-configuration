{
  users.users = {
    default = {
      name = "apollo";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "dialout"
      ];
    };
  };
}
