# Easy user options config file to help obviate the need for configuring common user differences in other .nix files

let
  # THINGS YOU NEED TO CHANGE
  username = "non";
  hostname = "nixrice";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/jwy-gh0stzk-dots";
in {

  inherit username hostname userHome flakeDir;

  # User Variables
  gitUsername = "James Yuen";
  gitEmail = "jwingy@gmail.com";
  
  wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git"; # This will give you my wallpapers
  # ^ (use as is or replace with your own repo - removing will break the wallsetter script) 
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  screenshotDir = "${userHome}/Pictures/Screenshots";
  flakePrev = "${userHome}/.zaneyos-previous";
  flakeBackup = "${userHome}/.zaneyos-backup";
  terminal = "kitty"; # This sets the terminal that is used by the hyprland terminal keybinding

  # System Settings
  clock24h = false;
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "de";
  theKBDVariant = "";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "America/New_York";
  theShell = "fish"; # Possible options: bash, zsh
  theKernel = "zen"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "x11"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "vm";
  gpuType = "vm";


  # Enable alternative wm
  kde = true;
  

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Enable Flatpak & Larger Programs
  distrobox = false;
  flatpak = false;
  kdenlive = false;
  blender = false;

  # Enable Support For
  # Logitech Devices
  logitech = true;

  # Enable Terminals
  # If You Disable All You Get Kitty
  wezterm = false;
  alacritty = true;
  kitty = true;

  # Enable Python & PyCharm
  python = false;
  
  # Enable SyncThing
  syncthing = true;

}
