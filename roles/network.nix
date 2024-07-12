{ pkgs, ... }:

{
  # Packages
  environment.systemPackages = with pkgs; [ nftables ];

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Fix for Network Manager permission issues
  programs.dconf.enable = true;

  # zerotier
  services.zerotierone.enable = true;
  services.zerotierone.joinNetworks = [ "88503383909e6f37" ]; # Petty Main
}
