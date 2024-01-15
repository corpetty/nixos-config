{ pkgs, ... }:

{
  imports = [
    ./security.nix
  ];

  /* Required tools and libraries. */
  environment.systemPackages = with pkgs; [
    ledger-udev-rules
  ];

}
