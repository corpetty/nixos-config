{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./fixes.nix
    ./helpers.nix
    ./metrics.nix
    ./security.nix
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    # utilities
    file zsh bash man-pages sudo pass bc pv rename uptimed lsb-release v4l-utils cpuid
    # building
    gnumake gcc autoconf automake patchelf
    unrar unzip zip envsubst entr
    # processes
    dtach reptyr pstree killall sysstat
    # monitoring
    htop iotop iftop multitail
    # dev tools
    neovim jq tmux fzf silver-searcher
    git qrencode sqlite gh
    # hardware tools
    pciutils lm_sensors acpi pmutils usbutils dmidecode
    # networking
    wget curl nmap nettools traceroute dnsutils wol iperf
    # filesystems
    ncdu zfs zfstools ranger lsof ntfs3g exfat
    # hard drive management
    lsscsi hddtemp hdparm perf-tools parted gptfdisk
    # network filesystems
    nfs-utils
    # security
    openssl
    # languages
    python3
  ];

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Editor
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  # Editor
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # SysRQ is useful when things hang
  boot.kernel.sysctl = { "kernel.sysrq" = 1; };

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # domain use for my own infra (from Jakub -CP)
  # networking.search = [ "PettyHouse" ];

  # NTP Server
  services.chrony.enable = true;

  # Uptime tracker
  services.uptimed.enable = true;
}
