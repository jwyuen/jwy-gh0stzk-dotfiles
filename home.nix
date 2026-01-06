{
  config,
  pkgs,
  inputs,
  username,
  host,
  gtkThemeFromScheme,
  ...
}:
let
  inherit (import ./nix-config/hosts/${host}/options.nix)
    gitUsername
    gitEmail
    theme
    browser
    wallpaperDir
    wallpaperGit
    flakeDir
    waybarStyle
    ;
in
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Import Program Configurations
  imports = [
    ./nix-config/home
  ];

  # Define Settings For Xresources
  xresources.properties = {
    "Xcursor.size" = 24;
  };

  # Install & Configure Git
  programs.git = {
    enable = true;
    settings = {
      user.email = "${gitEmail}";
      user.name = "${gitUsername}";
      core = {
        editor = "nvim";
        pager = "delta";
      };
    };
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs.home-manager.enable = true;
}
