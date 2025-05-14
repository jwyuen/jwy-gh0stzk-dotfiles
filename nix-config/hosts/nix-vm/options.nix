# Easy user options config file to help obviate the need for configuring common user differences in other .nix files

let
  # THINGS YOU NEED TO CHANGE
  setUsername = "non";
  setHostname = "nix-vm";
in
{

  #inherit username hostname userHome flakeDir;
  username = "${setUsername}";
  hostname = "${setHostname}";
  userHome = "/home/${setUsername}";
  flakeDir = "/home/${setUsername}/jwy-gh0stzk-dots";
  wallpaperDir = "/home/${setUsername}/Pictures/Wallpapers";
  screenshotDir = "/home/${setUsername}/Pictures/Screenshots";

  # User Variables
  gitUsername = "jwy";
  gitEmail = "jwingy@gmail.com";

  # System Settings
  clock24h = false;
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "de";
  theKBDVariant = "";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "America/New_York";
  theShell = "zsh"; # Possible options: bash, zsh
  theKernel = "default"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "x11"; # Either x11 or wayland ONLY. Games might require x11 set here

  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "vm";
  gpuType = "vm";

  # Nvidia Hybrid Devices ONLY NEEDED FOR HYBRID SYSTEMS! 
  amd-bus-id = "PCI:1:0:0";
  intel-bus-id = "PCI:1:0:0";
  nvidia-bus-id = "PCI:0:2:0";

  # DE / WM
  bspwm = true;
  kde = false;

  # Base16 Theme
  theme = "catppuccin-mocha";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Program options

  terminal = "alacritty"; # This sets the terminal that is used by the hyprland terminal keybinding
  browser = "firefox";
  distrobox = false;
  flatpak = false;
  kdenlive = false;
  blender = false;

  # Enable Support For
  # Logitech Devices
  logitech = false;

  # Enable Terminals
  # If You Disable All You Get Kitty
  wezterm = true;
  alacritty = true;
  kitty = false;

  # Enable Python & PyCharm
  python = false;

  # Enable SyncThing
  syncthing = true;

  # Xorg scaling
  x11ScaleFactor = "1.0";

  # Power profiles daemon
  powerprofiles = false;

  # Use lanzaboote for secureboot
  secureboot = false;
}
