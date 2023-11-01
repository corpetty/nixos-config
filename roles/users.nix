{ pkgs, ... }:

{
  # Give extra permissions with Nix
  nix.settings.trusted-users = [ "petty" ];

  users.groups.petty = {
    gid = 1000;
    name = "petty";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.petty = {
    uid = 1000;
    createHome = true;
    isNormalUser = true;
    useDefaultShell = true;
    group = "petty";
    extraGroups = [
      "wheel" "audio" "dialout" "video" "disk"
      "adm" "tty" "systemd-journal" "docker"
      "networkmanager" "cdrom"
    ];
    openssh.authorizedKeys.keys = [
    ];
  };

  # allow of sudo without password
  security.sudo.wheelNeedsPassword = false;

  system.userActivationScripts = {
   pettyDotfiles = let
     dotfilesSh = pkgs.substituteAll {
       src = ../files/dotfiles.sh;
       isExecutable = true;
       inherit (pkgs) bash git coreutils findutils gnused;
     };
   in "${dotfilesSh}";
  };
}
