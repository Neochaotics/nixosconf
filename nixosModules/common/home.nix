{
  users.users.quinno = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "Quinn O";
  };
  services.getty.autologinUser = "quinno";
  services.getty.autologinOnce = true;
}
