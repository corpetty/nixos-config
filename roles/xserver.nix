{ pkgs, ... }:

let
  disableAccelProfile = name:
    "xinput set-prop 'pointer:${name}' 'Device Accel Profile' -1";
in {
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    enableCtrlAltBackspace = true;
    windowManager.awesome.enable = true;
    displayManager = {
      defaultSession = "none+awesome";
      lightdm = {
        enable = true;
        background = "${../files/wallpapers/default.jpg}";
      };
      autoLogin.enable = true;
      autoLogin.user = "petty";
    };
    # symlink at /etc/X11/xorg.conf
    exportConfiguration = true;
  };

  # Fonts
  fonts = {
    fontconfig = {
      cache32Bit = true;
      allowBitmaps = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        monospace = [ "Inconsolata" ];
      };
    };
    fonts = with pkgs; [
      inconsolata
      terminus_font
      corefonts
      fira-code
      dejavu_fonts
      ubuntu_font_family
    ];
  };
}
