{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = true;
  };
  users.users.default.openssh.authorizedKeys.keyFiles = [ ];
}
