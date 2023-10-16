{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../roles/base.nix
    ../../roles/users.nix
    ../../roles/network.nix
    ../../roles/landing.nix
    ../../roles/locate.nix
    ../../roles/desktop.nix
    ../../roles/bluetooth.nix
    ../../roles/physlock.nix
    ../../roles/printer.nix
    ../../roles/gaming.nix
    ../../roles/docker.nix
    ../../roles/yubikey.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  # Resume
  systemd.sleep.extraConfig = "HibernateMode=reboot";

  # Sensors
  boot.kernelModules = [ "nct6775" "coretemp" "i2c-1" ];
  boot.kernelPackages = pkgs.linuxPackages_6_1;

  networking = {
    hostName = "bean";
    useDHCP = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";
  # Avoid difference when dual-booting Windows.
  time.hardwareClockInLocalTime = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Video
  services.xserver.videoDrivers = [ "nvidia" "intel" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidiaSettings = true;
    modesetting.enable = true;
  };

  # Power Management
  powerManagement.cpuFreqGovernor = "performance";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "20.09";

  systemd.coredump.enable = true;
}