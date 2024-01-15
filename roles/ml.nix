{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cudatoolkit
    linuxPackages.nvidia_x11
    xorg.libXi
    xorg.libXmu
    freeglut
    xorg.libXext
    xorg.libX11
    xorg.libXv
    xorg.libXrandr
    zlib

    # for xformers
    gcc
  ];

  users.users.petty.packages = with pkgs; [
    stdenv.cc.cc.lib
    stdenv.cc
    ncurses5
    binutils
    gitRepo autoconf curl
    procps gnumake util-linux m4 gperf unzip
    libGLU libGL
    glib
  ];

  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };



}
