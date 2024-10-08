{ lib, pkgs, config, host, ... }:

let inherit (import ../hosts/${host}/options.nix) theKBDVariant
theKBDLayout theSecondKBDLayout; in
{
  #hardware.video.hidpi.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      variant = "${theKBDVariant}";
      layout = "${theKBDLayout}, ${theSecondKBDLayout}";
      options = "ctrl:nocaps";
    };
  };
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = true;
    theme = "tokyo-night-sddm";
  };
  services.libinput.enable = true;

 # environment.variables = {
 #   GDK_SCALE = "1.2";
 #   GDK_DPI_SCALE = "0.8";
 #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=1.2";
 # };
  environment.systemPackages =
    let
      sugar = pkgs.callPackage ../pkgs/sddm-sugar-dark.nix {};
      tokyo-night = pkgs.libsForQt5.callPackage ../pkgs/sddm-tokyo-night.nix {};
    in [ 
      sugar.sddm-sugar-dark # Name: sugar-dark
      tokyo-night # Name: tokyo-night-sddm
      pkgs.libsForQt5.qt5.qtgraphicaleffects
    ];
}
