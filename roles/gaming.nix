{ pkgs, ... }:

{
  # Enable 32bit OpenGL and PulseAudio
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # Gaming mouse configuration
  # services.ratbagd.enable = true;

  # XBox Pad kernel driver.
  hardware.xone.enable = false;
  hardware.xpadneo.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Packages required for work
  users.users.petty.packages = with pkgs; [
    steam
    lutris
    corefonts
    vulkan-tools
    # Wine
    wineWowPackages.stableFull
    winetricks
    # Mouse
    piper
    # Games
    #dwarf-fortress-packages.dwarf-fortress-full
  ];
}