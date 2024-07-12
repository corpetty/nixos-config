{ pkgs, ... }:

{
  # Daemon
  services.locate.enable = true;
  services.locate.package = pkgs.mlocate;
  services.locate.interval = "daily";
  services.locate.prunePaths = [ "/mnt/torrent" ];
  services.locate.localuser = null; # Fix user warning
}

